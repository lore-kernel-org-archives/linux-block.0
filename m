Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6E5C433B4
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 21:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356B16143F
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 21:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhD2VJM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Apr 2021 17:09:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:59594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233284AbhD2VJM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 17:09:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619730504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NciCyiZPbzmP9EScIm/d+xm3xtaz9st0CdLXaGyBKAA=;
        b=bApUfTXPm/wI2imdS+EWNVSHT9FhuAD8easnpdKfveQU7U/CVv5lzGOwSzrWx6DlcQYJGd
        Tlva44Ae2NbHP+ldNvBZRofz55QGL/5NP4kSBtALg5PZq2eSwAzJMOyIxkUK/Kpnhbl4jg
        SGmJ4/R91TIzL/7zsQFA6ugLSz6uvvo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B6BFB20E;
        Thu, 29 Apr 2021 21:08:24 +0000 (UTC)
Message-ID: <413c998fd75f6bc9c7f70d8a1a2b107b443a75a0.camel@suse.com>
Subject: Re: [dm-devel] [RFC PATCH v2 2/2] dm: add CONFIG_DM_MULTIPATH_SG_IO
 - failover for SG_IO on dm-multipath
From:   Martin Wilck <mwilck@suse.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Date:   Thu, 29 Apr 2021 23:08:23 +0200
In-Reply-To: <5d1967f2-8017-c711-dec0-3ffe751974de@acm.org>
References: <20210429155024.4947-1-mwilck@suse.com>
         <20210429155024.4947-3-mwilck@suse.com>
         <5d1967f2-8017-c711-dec0-3ffe751974de@acm.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2021-04-29 at 09:32 -0700, Bart Van Assche wrote:
> On 4/29/21 8:50 AM, mwilck@suse.com wrote:
> > +       if (hdr.dxfer_len > (queue_max_hw_sectors(bdev->bd_disk-
> > >queue) << 9))
> > +               return -EIO;
> 
> How about using SECTOR_SHIFT instead of the number 9?

no problem. That line was just copied from the scsi_ioctl code.

> 
> > +               /*
> > +                * Errors resulting from invalid parameters
> > shouldn't be retried
> > +                * on another path.
> > +                */
> > +               switch (rc) {
> > +               case -ENOIOCTLCMD:
> > +               case -EFAULT:
> > +               case -EINVAL:
> > +               case -EPERM:
> > +                       goto out;
> > +               default:
> > +                       break;
> > +               }
> 
> Will -ENOMEM result in an immediate retry? Is that what's desired?

No, I overlooked that case. Thanks for pointing this out. 

> 
> > +               if (rhdr.info & SG_INFO_CHECK) {
> > +                       int result;
> > +                       blk_status_t sts;
> > +
> > +                       __set_status_byte(&result, rhdr.status);
> > +                       __set_msg_byte(&result, rhdr.msg_status);
> > +                       __set_host_byte(&result, rhdr.host_status);
> > +                       __set_driver_byte(&result,
> > rhdr.driver_status);
> > +
> > +                       sts = __scsi_result_to_blk_status(&result,
> > result);
> > +                       rhdr.host_status = host_byte(result);
> > +
> > +                       /* See if this is a target or path error.
> > */
> > +                       if (sts == BLK_STS_OK)
> > +                               rc = 0;
> > +                       else if (blk_path_error(sts))
> > +                               rc = -EIO;
> > +                       else {
> > +                               rc = blk_status_to_errno(sts);
> > +                               goto out;
> > +                       }
> > +               }
> 
> Will SAM_STAT_CHECK_CONDITION be treated as an I/O error? Is that
> what's
> desired? If not, does that mean that scsi_result_to_blk_status()
> shouldn't be used but instead that a custom SCSI result conversion is
> needed?

This mimics the logic for regular SCSI block I/O. By default, CHECK
CONDITION indeed maps to a BLK_STS_IO_ERR, and will be treated as a
path error. As you probably know, there are some exceptions that are
handled in the SCSI mid-layer beforehand. For example, check_sense()
sets DID_TARGET_FAILURE or DID_MEDIUM_ERROR for certain sense codes,
which map to target errors. So yes, I think this is correct.

> If __scsi_result_to_blk_status() is the right function to call, how
> about making that function accept the driver status, host status, msg
> and SAM status as four separate arguments such that the
> __set_*_byte()
> calls can be left out?
> 
> > +                       char *argv[2] = { "fail_path", bdbuf };
> 
> Can the above array be declared static?

How would that work? The function needs to be reentrant, and bdbuf is
on the stack. I don't see an issue here, it's really just two pointers
on the stack.

Regards,
Martin


