Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB57AC282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 16:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A610721919
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 16:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wemmN42B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfBGQfY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:35:24 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:36072 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGQfX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 11:35:23 -0500
Received: by mail-it1-f194.google.com with SMTP id c9so1243947itj.1
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 08:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=34L9plswwBn3yKG3/t6fivFt5xXS9dSo9ffqr5Q+Kvw=;
        b=wemmN42Br150wil6w2UfLL0sQPGumFAZJh7p6glq4GD2hjTctCBnxp5px2qrTbVLoE
         3aSv5DhNM+hU+GJF9lwMw93ChIjC4DWZ9VamPVkzKK+x5rEYQT3JvDiyFAylrmkYUgVp
         KixfoTKl3OZ6pWwmPSy6u+NSkvHJZRQ33Phl5tS9L45r+lE7EBu4vOE8v5+RW7QtJSsh
         HtC0y813+zOFqlQs4OBSPtahUfFazMnRX0xMDXBVfWSDlwl807QUuDrDgffjqdSIaJNV
         9sEkzZQhV90GdYTdD/xUaNxm3RGZw9Mxcd+4E4FZcSBp+Ot3okkwlqeVIVgJo7Vnoibn
         yx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=34L9plswwBn3yKG3/t6fivFt5xXS9dSo9ffqr5Q+Kvw=;
        b=jYXhI0T8Fa1qxByeRHdIr9SJKg4vPRIrLlWt/De78BThzTP1rqt8EDTqAFXf8LR+je
         7TYYL529spdJ+Fk8DnWauXvG5fXau2O28QCpsroxZZKJQ+wuGREdS8N5cvfWiYynwj/S
         1Q9BQYuYD2tZua0hISmQmgtA/SRbgr7GpfPbXz7uF/rKve5D8IIuud7dcLadvrJmc6Q1
         ZCnETjYCCKZAz3P+j207iFdMHq0H18EV0apYv2XeReYodyZCv0XDYcSWGaFGeBfmA/En
         9+6Ny/4jgPluoBAqBb6YNaYQVBNL68zy7ioxhH/w/jR7ZmW1zrw7U64hsLb8yMgy81U7
         Ej8w==
X-Gm-Message-State: AHQUAuYbkEICJcifd1PAVOfUidh/cGpf8q/Xl2I857QsraxAEXMIvLyP
        Ugf1bHEnyNc3Looa26EIb7fm1Q==
X-Google-Smtp-Source: AHgI3IaQqWg5jcPE3hP/dIkhY3UWTUQ8A3d4b5EXifa5Xn0VLugfgdJjj5UZKD19dWD+vKa/Ngo7Zw==
X-Received: by 2002:a05:660c:a48:: with SMTP id j8mr4372738itl.26.1549557322659;
        Thu, 07 Feb 2019 08:35:22 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x128sm5810948itb.8.2019.02.07.08.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 08:35:21 -0800 (PST)
Subject: Re: [PATCH 13/18] io_uring: add file set registration
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jann Horn <jannh@google.com>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        linux-fsdevel@vger.kernel.org
References: <CAG48ez2kLWUEambWesQQaeVn_u=PtjuMeDUc49yamhYspfd7Sg@mail.gmail.com>
 <20190204025612.GR2217@ZenIV.linux.org.uk>
 <785c6db4-095e-65b0-ded5-72b41af5174e@kernel.dk>
 <2b2137ed-8107-f7b6-f0ca-202dcfb87c97@kernel.dk>
 <40b27e78-9ee8-1395-feb3-a73aac87c9a7@kernel.dk>
 <0d2e5085-32ff-e86e-d628-6000071fd132@kernel.dk>
 <20190206010104.GV2217@ZenIV.linux.org.uk>
 <608c1102-5818-e38c-cfc7-b1cec5a1ecb4@kernel.dk>
 <20190207040547.GX2217@ZenIV.linux.org.uk>
 <51f167c6-aacc-dd5b-4481-7168c6f8b413@kernel.dk>
 <20190207163047.GE2217@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eb9fa2d8-ffe2-0a35-a951-3e5581f00bd4@kernel.dk>
Date:   Thu, 7 Feb 2019 09:35:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207163047.GE2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/7/19 9:30 AM, Al Viro wrote:
> On Thu, Feb 07, 2019 at 09:14:41AM -0700, Jens Axboe wrote:
> 
>> I created a small app to do just that, and ran it and verified that
>> ->release() is called and the io_uring is released as expected. This
>> is run on the current -git branch, which has a socket backing for
>> the io_uring fd itself, but not for the registered files.
>>
>> What am I missing here? Attaching the program as a reference.
> 
>> int main(int argc, char *argv[])
>> {
>> 	int sp[2], pid, ring_fd, ret;
>>
>> 	if (socketpair(AF_UNIX, SOCK_DGRAM, 0, sp) != 0) {
>> 		perror("Failed to create Unix-domain socket pair\n");
>> 		return 1;
>> 	}
>>
>> 	ring_fd = get_ring_fd();
>> 	if (ring_fd < 0)
>> 		return 1;
>>
>> 	ret = io_uring_register_files(ring_fd, sp[0], sp[1]);
>> 	if (ret < 0) {
>> 		perror("register files");
>> 		return 1;
>> 	}
>>
>> 	pid = fork();
>> 	if (pid) {
>> 		printf("Sending fd %d\n", ring_fd);
>>
>> 		send_fd(sp[0], ring_fd);
>> 	} else {
>> 		int fd;
>>
>> 		fd = recv_fd(sp[1]);
> 
> Well, yes - once you receive it, you obviously have no references
> sitting in SCM_RIGHTS anymore.
> 
> Get rid of recv_fd() there (along with fork(), while we are at it - what's
> it for?) and just do send_fd + these 3 close (or just exit, for that matter).

Ah got it, yes you are right, that does leak.

Thanks for the other (very) detailed note, I'll add a socket backing for the
registered files. I'll respond to the other details in there a bit later.

-- 
Jens Axboe

