Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BCFC433B4
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 20:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED9C61424
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 20:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbhD2UeR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Apr 2021 16:34:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:42044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236983AbhD2UeQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 16:34:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619728408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nXujdk0LEa7B6Wqz6rZ0sXsyUgIYETxsrGPYGr700lo=;
        b=AwpJ5T2EWB26uU24akQ1F4yc04MbZvggMwr0zpPLmxxM6w1HOkmyhA+4p2/9rwtC/wKMEq
        Lb47voCIKXb2vLvrSldy0Bdf1V51Td8K0a7bNA8o8QUGZT0bIDpjVkUt32kYQOfR/yHOrV
        NDhPcZphb40uMAJAHN9muGj1VlFozMI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7AA47ADD7;
        Thu, 29 Apr 2021 20:33:28 +0000 (UTC)
Message-ID: <bb30875e11913a33bcaf491d0f752132ebb9ce5e.camel@suse.com>
Subject: Re: [dm-devel] [RFC PATCH v2 1/2] scsi: convert
 scsi_result_to_blk_status() to inline
From:   Martin Wilck <mwilck@suse.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Thu, 29 Apr 2021 22:33:27 +0200
In-Reply-To: <08440651-6e8f-734a-ef43-561d9c2596a6@acm.org>
References: <20210429155024.4947-1-mwilck@suse.com>
         <20210429155024.4947-2-mwilck@suse.com>
         <08440651-6e8f-734a-ef43-561d9c2596a6@acm.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

thanks for looking at this.

On Thu, 2021-04-29 at 09:20 -0700, Bart Van Assche wrote:
> On 4/29/21 8:50 AM, mwilck@suse.com wrote:
> > This makes it possible to use scsi_result_to_blk_status() from
> > code that shouldn't depend on scsi_mod (e.g. device mapper).
> 
> I think that's the wrong reason to make a function inline. Please
> consider moving scsi_result_to_blk_status() into one of the block
> layer
> source code files that already deals with SG I/O, e.g.
> block/scsi_ioctl.c.

scsi_ioctl.c, are you certain? scsi_result_to_blk_status() is an
important part of the block/scsi interface... You're right that that
this function is not a prime candidate for inlining, but I'm still
wondering where it belongs if we don't.

Looking forward to see what others think.

> 
> > diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
> > index 83f7e520be48..ba1e69d3bed9 100644
> > --- a/include/scsi/scsi_cmnd.h
> > +++ b/include/scsi/scsi_cmnd.h
> > @@ -311,24 +311,44 @@ static inline struct scsi_data_buffer
> > *scsi_prot(struct scsi_cmnd *cmd)
> >  #define scsi_for_each_prot_sg(cmd, sg, nseg, __i)              \
> >         for_each_sg(scsi_prot_sglist(cmd), sg, nseg, __i)
> >  
> > +static inline void __set_status_byte(int *result, char status)
> > +{
> > +       *result = (*result & 0xffffff00) | status;
> > +}
> > +
> >  static inline void set_status_byte(struct scsi_cmnd *cmd, char
> > status)
> >  {
> > -       cmd->result = (cmd->result & 0xffffff00) | status;
> > +       __set_status_byte(&cmd->result, status);
> > +}
> > +
> > +static inline void __set_msg_byte(int *result, char status)
> > +{
> > +       *result = (*result & 0xffff00ff) | (status << 8);
> >  }
> >  
> >  static inline void set_msg_byte(struct scsi_cmnd *cmd, char
> > status)
> >  {
> > -       cmd->result = (cmd->result & 0xffff00ff) | (status << 8);
> > +       __set_msg_byte(&cmd->result, status);
> > +}
> > +
> > +static inline void __set_host_byte(int *result, char status)
> > +{
> > +       *result = (*result & 0xff00ffff) | (status << 16);
> >  }
> >  
> >  static inline void set_host_byte(struct scsi_cmnd *cmd, char
> > status)
> >  {
> > -       cmd->result = (cmd->result & 0xff00ffff) | (status << 16);
> > +       __set_host_byte(&cmd->result, status);
> > +}
> > +
> > +static inline void __set_driver_byte(int *result, char status)
> > +{
> > +       *result = (*result & 0x00ffffff) | (status << 24);
> >  }
> >  
> >  static inline void set_driver_byte(struct scsi_cmnd *cmd, char
> > status)
> >  {
> > -       cmd->result = (cmd->result & 0x00ffffff) | (status << 24);
> > +       __set_driver_byte(&cmd->result, status);
> >  }
> 
> The layout of the SCSI result won't change since it is used in
> multiple
> UAPI data structures. I'd prefer to open-code host_byte() in
> scsi_result_to_blk_status() instead of making the above changes.

OK. I'm generally no fan of hard-coding but I guess you're right
in this case.

Thanks,
Martin




