Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E861AC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB11F2146D
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIDhEg57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB11F2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeLERz5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:55:57 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35241 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeLERz4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 12:55:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so9373823pgs.2
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 09:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NN4Tv1HFl293v26vJ9Sy7RTT1sHdhtpxa1bepmvSWOs=;
        b=IIDhEg57EDk0cOcebVgYj+Rl8CuIjucTqQPddfvW2n3bjYJVB7J6U80ckAceoa1Vdl
         KkY11jqptV5JYZzgreoitf1cxaJph07RyisBBQ7fWri4RL38y4arDxe0FM5uYh9JkGdL
         +NhtU8RHE8p4gi8cBSxZfIevnCh1KzHf8KORWuv2FVnqtHNtqp37t+oRhhBl8wj2x7e1
         KQl/MDlG4yemZ24BpG7wbJ41z9DkH0g3zpP60712spmqkegKbB7q6YP4kFerDU58aPbg
         Hj6Aw5QRhAuo+vc3q2s2V7WVJIXfko4x+99/QSLhUqjhAZE/7v5UTtqhn+AyG3usPD6i
         B2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NN4Tv1HFl293v26vJ9Sy7RTT1sHdhtpxa1bepmvSWOs=;
        b=FPJzXXzFCVGkoaw73d1+7K/ZSvdxDJhOfk78+LWefu4/bKZBBuswjK9IPTse4scvdG
         hG0Yl2Z1iOr9X2Ka06FxJ79QPDCQzG7C86j0tX4OPUUkfdY16dlMlNbaqCzmfSMGP+MR
         29A9OwG4MxBvugXXIlW/4AqaYiu6rO/urP2mtTdsS87O1q+WJJoJftD1Tzd9SgnLndee
         jLhaxTlHE+GRnwc3Iqbn7sn0z2awU5FGSBBhmND20RwTzRNPO6t4sKzBsweKx1xIYr9a
         DE7Tt+O3373jDMfTImD5+zvgUnawqe0ECfdd+ZedMw7b4tp/Ywxgowd+QfuFTQXgXaOr
         0+LA==
X-Gm-Message-State: AA+aEWb1Jm0C+xsoW8WG4lTpsBfqXciFe9uTYQzA4a86AzqZGP69TFF+
        1hwNY87C3wAEUb7fDQfA/qFmk/W2
X-Google-Smtp-Source: AFSGD/UbtwToJJahcjm6EP96cPDEojui1ZaMxY+rZHKnXNbenfa9aOlYbNe415T4e+tAci7B8jEIPg==
X-Received: by 2002:a63:790e:: with SMTP id u14mr19992651pgc.452.1544032555744;
        Wed, 05 Dec 2018 09:55:55 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e23sm28504367pfh.68.2018.12.05.09.55.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:55:55 -0800 (PST)
Date:   Wed, 5 Dec 2018 09:55:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: fix corruption with direct issue
Message-ID: <20181205175554.GA1810@roeck-us.net>
References: <1d359819-5410-7af2-d02b-f0ecca39d2c9@kernel.dk>
 <20181205013821.GA19605@roeck-us.net>
 <7aa746ff-58ab-e0e9-7058-3086a7f19c47@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aa746ff-58ab-e0e9-7058-3086a7f19c47@kernel.dk>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 04, 2018 at 07:25:05PM -0700, Jens Axboe wrote:
> On 12/4/18 6:38 PM, Guenter Roeck wrote:
> > On Tue, Dec 04, 2018 at 03:47:46PM -0700, Jens Axboe wrote:
> >> If we attempt a direct issue to a SCSI device, and it returns BUSY, then
> >> we queue the request up normally. However, the SCSI layer may have
> >> already setup SG tables etc for this particular command. If we later
> >> merge with this request, then the old tables are no longer valid. Once
> >> we issue the IO, we only read/write the original part of the request,
> >> not the new state of it.
> >>
> >> This causes data corruption, and is most often noticed with the file
> >> system complaining about the just read data being invalid:
> >>
> >> [  235.934465] EXT4-fs error (device sda1): ext4_iget:4831: inode #7142: comm dpkg-query: bad extra_isize 24937 (inode size 256)
> >>
> >> because most of it is garbage...
> >>
> >> This doesn't happen from the normal issue path, as we will simply defer
> >> the request to the hardware queue dispatch list if we fail. Once it's on
> >> the dispatch list, we never merge with it.
> >>
> >> Fix this from the direct issue path by flagging the request as
> >> REQ_NOMERGE so we don't change the size of it before issue.
> >>
> >> See also:
> >>   https://bugzilla.kernel.org/show_bug.cgi?id=201685
> >>
> >> Fixes: 6ce3dd6eec1 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > 
> > Tested-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > ... on two systems affected by the problem.
> 
> Thanks for testing! And for being persistent in reproducing and
> providing clues for getting this nailed.
> 

My pleasure.

I see that there is some discussion about this patch.

Unfortunately, everyone running a 4.19 or later kernel is at serious
risk of data corruption. Given that, if this patch doesn't make it
upstream for one reason or another, would it be possible to at least
revert the two patches introducing the problem until this is sorted
out for good ? If this is not acceptable either, maybe mark blk-mq
as broken ? After all, it _is_ broken. This is even more true if it
turns out that a problem may exist since 4.1, as suggested in the
discussion.

Also, it seems to me that even with this problem fixed, blk-mq may not
be ready for primetime after all. With that in mind, maybe commit
d5038a13eca72 ("scsi: core: switch to scsi-mq by default") was a
bit premature. Should that be reverted ?

Thanks,
Guenter
