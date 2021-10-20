Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB0CC433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90ED661371
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhJTNBE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 09:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTNBE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 09:01:04 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E115CC06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:58:49 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y30so23693953edi.0
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MJVfbi55Dk1YDovjc7D4hApKuxZCGc/YpR/kWVxB/N0=;
        b=LjU8ug8cJTnAp4eZRdDRr5mob72dRHD+/ejzfVbtqO4Y1BzDFGtyr5lyj6OAbEqVA9
         OVslqhuHz9/ZLRC0Sup8I8Ojl7VvKkPAWqNsYhV920cN9q5f0bcsewshU+rfcDe1QmXF
         KYTHVK2aLNXRuczUq6F0UbYjSQckG4ASdNRcdhrZGU1C9Jk2c+0Si6Ecr51uRnlx2KsL
         s6MozPlDVgpl28VWA2Enwaa4gyeKYlsaRX01zZHXRd2qvSsB+bpqyB6SE2ZHCL/c4qqk
         7Qfehd1bHhcALWUsu6yyGVBedxd7tDndA8sYavGk/5wMQfl5gE9H0n5eHIHBe1sLW65Q
         5nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MJVfbi55Dk1YDovjc7D4hApKuxZCGc/YpR/kWVxB/N0=;
        b=skS5HpVOvIA9WsdeYP6DRFumCcuMKoOw52Ee3kWX1HwqIcfo/5FFaDsNRtlZt4IsdD
         zNFvCtIKng3kjZ/EsU3UVdnewn/nDysm860r5zFUQOu4OnTrBHzCslREsmyUilfmrG9P
         fPQaMgVpJEjTSD68ND6BEd6Z5vFxHNAp48Mqmyj+vAzNbAhZ+ZoKI6DhfeW88PwMgOy3
         D/YwOnh3DKR8p3kTmo85N82Dx3m6iNFmxac5/9pQjzFWUbsOty8Xx/Glz0ySi8EsKOLp
         P3hciooBW+ajjjMXH1KtIZb4/TNZ8dbAGABeBAQ7nmm5AqIRnZ1aTJVNC9C2sop5hNZr
         RugA==
X-Gm-Message-State: AOAM533SXcGtSZ/rYlfj6YQrLGyX+lrqUD9jQ/etM2BJIJa2MPrX0HX0
        j3aVnLUxJGz1j83zvniy8hY=
X-Google-Smtp-Source: ABdhPJySTrTO6bcR5U+i5IZTY4JtF1HrGXpK6eHzJJZA2bazk8SgRSJHcve7gbWegwracnRBtJYzYQ==
X-Received: by 2002:a17:906:bc43:: with SMTP id s3mr45615113ejv.46.1634734713381;
        Wed, 20 Oct 2021 05:58:33 -0700 (PDT)
Received: from [192.168.43.77] (82-132-229-137.dab.02.net. [82.132.229.137])
        by smtp.gmail.com with ESMTPSA id j3sm1012126ejy.65.2021.10.20.05.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 05:58:33 -0700 (PDT)
Message-ID: <eed20b36-8df8-3c0f-17fa-0e23463c707f@gmail.com>
Date:   Wed, 20 Oct 2021 13:58:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 13/16] block: add async version of bio_set_polled
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <673fc6ca8f2e761586d21c709348642113f13f86.1634676157.git.asml.silence@gmail.com>
 <YW+5Ic7v++qXiGXw@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YW+5Ic7v++qXiGXw@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/21 07:37, Christoph Hellwig wrote:
> On Tue, Oct 19, 2021 at 10:24:22PM +0100, Pavel Begunkov wrote:
>> If we know that a iocb is async we can optimise bio_set_polled() a bit,
>> add a new helper bio_set_polled_async().
> 
> This avoids a single if.  Why?  I'm really worried about all these
> micro-optimizations that just make the code harder and harder to
> maintain.

Not really just one, it also moves REQ_F_NOWAIT, and alias analysis
doesn't work well here, e.g. it can't conclude anything about
relations b/w @iocb and @bio, those can do nothing but store/load
to/from memory.

Assembly related to that HIPRI path before:

# block/fops.c:378: 	if (iocb->ki_flags & IOCB_NOWAIT)
	movl	32(%rbx), %eax	# iocb_31(D)->ki_flags, _20
# block/fops.c:378: 	if (iocb->ki_flags & IOCB_NOWAIT)
	testb	$8, %al	#, _20
	je	.L200	#,
# block/fops.c:379: 		bio->bi_opf |= REQ_NOWAIT;
	orl	$2097152, 16(%r12)	#, bio_40->bi_opf
# block/fops.c:380: 	if (iocb->ki_flags & IOCB_HIPRI) {
	movl	32(%rbx), %eax	# iocb_31(D)->ki_flags, _20
.L200:
# block/fops.c:380: 	if (iocb->ki_flags & IOCB_HIPRI) {
	testb	$1, %al	#, _20
	je	.L201	#,
# ./include/linux/bio.h:748: 	bio->bi_opf |= REQ_POLLED;
	movl	16(%r12), %eax	# bio_40->bi_opf, _73
	movl	%eax, %edx	# _73, tmp138
	orl	$16777216, %edx	#, tmp138
	movl	%edx, 16(%r12)	# tmp138, bio_40->bi_opf
# ./include/linux/bio.h:749: 	if (!is_sync_kiocb(kiocb))
	cmpq	$0, 16(%rbx)	#, iocb_31(D)->ki_complete
	je	.L202	#,
# ./include/linux/bio.h:750: 		bio->bi_opf |= REQ_NOWAIT;
	orl	$18874368, %eax	#, tmp139
	movl	%eax, 16(%r12)	# tmp139, bio_40->bi_opf
.L202:
# block/fops.c:382: 		submit_bio(bio);
	movq	%r12, %rdi	# bio,
	call	submit_bio	#

After:

# block/fops.c:378: 	if (iocb->ki_flags & IOCB_HIPRI) {
	movl	32(%rbx), %eax	# iocb_30(D)->ki_flags, _20
# block/fops.c:378: 	if (iocb->ki_flags & IOCB_HIPRI) {
	testb	$1, %al	#, _20
	je	.L210	#,
.L213:
# ./include/linux/bio.h:755: 	bio->bi_opf |= REQ_POLLED | REQ_NOWAIT;
	orl	$18874368, 16(%r12)	#, bio_39->bi_opf
# block/fops.c:380: 		submit_bio(bio);
	movq	%r12, %rdi	# bio,
	call	submit_bio	#


-- 
Pavel Begunkov
