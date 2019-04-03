Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED17C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5337E20657
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 17:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDCR6x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:58:53 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44895 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCR6x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 13:58:53 -0400
Received: by mail-qk1-f193.google.com with SMTP id y5so10698053qkc.11
        for <linux-block@vger.kernel.org>; Wed, 03 Apr 2019 10:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NbBADe8BnlMZ3buvx1xOgIvv47mYMsumf3Xh5APo1MM=;
        b=f3nCXdBEsMWWg9DkXEyryPcfcHOfj+ZpzQ9qajcqkqtIbyVReOHht+oHIKakB+xf7J
         4MpSRwZVjUpbG/gXOMB0cIJt08e3iQgub6RDqm0ZvASjQ3P1HsSiepbEnqXGkYvNHLFc
         21xkrBq7chEf3JhHKDy+5RqtZ2i236O3jye1Yg2XCCTt1vynfKEczVNE6ixTFbZzjvkE
         ivMTtyzB8WpAL2kWEm9hS7rwRTNgyhNZLCfjxeakm6WKE07g5oUi+bBnh8SF3SNwRhAN
         AVlwZZRPlLy1aB1gCAAsDw/rwnordlSKhg/cwqP9/PfXCX/8To9eHsAM81QuJFhybhqK
         nO2A==
X-Gm-Message-State: APjAAAWhVNz/EfDTeoVAXYitUlIVvWYavlqUt3uwcbFm5GELXQHiINdN
        DwQC6yzdAWTX9zhNw9OIAPpEgQ==
X-Google-Smtp-Source: APXvYqxUKpz6BPUaXo8C92+oZujA5Z72kfx8P0khoN4VUzMR/EiUbDXcJRStODi17ebN13TmhTB5BQ==
X-Received: by 2002:a37:a02:: with SMTP id 2mr1220560qkk.258.1554314332303;
        Wed, 03 Apr 2019 10:58:52 -0700 (PDT)
Received: from dhcp-49-37.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id f191sm2271392qke.28.2019.04.03.10.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 10:58:51 -0700 (PDT)
Message-ID: <abd6470464bc26d780504453bd3cb629eb992aa6.camel@redhat.com>
Subject: Re: Panic when rebooting target server testing srp on 5.0.0-rc2
From:   Laurence Oberman <loberman@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>
Date:   Wed, 03 Apr 2019 13:58:50 -0400
In-Reply-To: <1554304176.118779.178.camel@acm.org>
References: <6e19971d315f4a3ce2cc20a1c6693f4a263a280c.camel@redhat.com>
         <7858e19ce3fc3ebf7845494a2209c58cd9e3086d.camel@redhat.com>
         <1553113730.65329.60.camel@acm.org>
         <3645c45e88523d4b242333d96adbb492ab100f97.camel@redhat.com>
         <d9febee1de759206bbf4d66f6570415ae64e4f33.camel@redhat.com>
         <8a6807100283a0c1256410f4f0381979b18398fe.camel@redhat.com>
         <10c96c79ed7a51ec22c6ccecbdbc3323655903b1.camel@redhat.com>
         <3a0e6f4b35742a31dc5f11fab30dbdacf673b9ba.camel@redhat.com>
         <1554304176.118779.178.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-04-03 at 08:09 -0700, Bart Van Assche wrote:
> On Wed, 2019-04-03 at 10:53 -0400, Laurence Oberman wrote:
> > Update on this issue
> > 
> > If I reset the SRP target server and do not reboot it I do not see
> > the
> > block-mq race with the SRP initiator.
> > Just resetting the SRP target array and not runing the reboot
> > avoids
> > the shutdown scripts of ib_srpt and seems somehow to prevent the
> > race
> > with the initiator code.
> > 
> > Given that I see very little churn and activity with LIO lately I
> > dont
> > know if its worth spending more time on trying to isolate this.
> > 
> > If anybody has an SRP native array (like DDN) and can reboot it
> > with
> > 5.x plus, that would be a good test.
> > 
> > I will reach out to DDN and ask if they can test it.
> 
> Hi Laurence,
> 
> If the initiator side crashes it means there is a bug in the kernel
> at the
> initiator side. It's not clear to me why you are commenting on the
> target
> side in this e-mail thread?
> 
> Thanks,
> 
> Bart.

Hello Bart

It does indeed seem to be an initiator issue but related to something
when the target reboots. Resetting the target, the initiator survives.
I did not know this until today. 
Until today was rebooting the targetserver to reproduce the race on the
initiator side.
Today I started testing the same way as I was when I repriduced the
Qlogic lock recursion, and In noticed I could not longer reproduce it.

In other words rebooting the target closes the SRP target ports in such
a way that the initiator gets into the block-mq issue race.
Using echo b or power reset the array just dissapears and tyhe
initiator is fine.

Apologies if I was not clear.

Regards
Laurence


