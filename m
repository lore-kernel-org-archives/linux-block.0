Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB09AECAAA1
	for <linux-block@archiver.kernel.org>; Wed, 31 Aug 2022 00:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiHaA7Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Aug 2022 20:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHaA7P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Aug 2022 20:59:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B77FA9C0E
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 17:59:14 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id j9-20020a17090a3e0900b001fd9568b117so9884697pjc.3
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 17:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Ivk89S//3lMPfDjeDOSlX80rCHqMBFqCmhfspnuz5iE=;
        b=yeCZaq97fhM/ZSTxMqV5eET1mcXZmeeZkxq2gBJ0hmUpy9yS3KIOkInOBkj44OMj30
         Ioi6KanKDdn0MyqladlAsBO3YgMZ+Tkidl4ptcSE+GuSn1eq5SIL0+SNQx67ZWq6QLsO
         I9mu8RTl8mFqaJQdrH67hxqAenTit8TMAcSuoYs9JL7W7xi/Istc8DJvFlfZJJvJeKWh
         JWcHieAVcAmNyRsi1f+1EJC0eT6tOReNkI97GS0XpB7ETN2K8s18nEOu6al/cHUkCIzR
         S3fWUnZ1dsS7IzPr6hq/pbZeryITlwGtcB+CKzhpR8wgW9t2xDVngBnn6KSi59gZb785
         sCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Ivk89S//3lMPfDjeDOSlX80rCHqMBFqCmhfspnuz5iE=;
        b=UzQ/tsRAVg1WVwaykPzZ7MRn5gENj2bw8wOIAUb5h8tKMCBX8DFJFVHIJQKYbgpH4W
         av3D7toXYy3uTmORx9VUffjh552A2yNB/Yjo1Cw6Jufy0cYi46IR5tY1aMGNKtzrjRVR
         54H+ljuNrQBcuf3FbfDccBDFgcTr4Wo/HGY6Ecb5jufvRK1BxEWpaBvsbCVwlOjIqQ0M
         IXDkEwq9vDFof2BGZWB15KB+yOGQjOGuMwp9A8NqGCXzm02fHYYMGw6wwltcLWawhJtw
         twAj5NVhMvMXkF3WoumygEqryNydjCQ9uQ9xEfm6lxyEgtfxf8y0eJQ124HidvoBFEOE
         1OaQ==
X-Gm-Message-State: ACgBeo0M0vfAc+fgv4BMiI7frThIWhmILKVI8bgHUCeNLdacppEz1j3Q
        jRTHs9X6cMP1a1PGOQb16H+m9a3MjbrtmA==
X-Google-Smtp-Source: AA6agR7t+Wdo+DUPWiV53oGE/ZgED8jOWI/E+P8+cFQnQONqC/0TUVP+Wptb7W9ds6I/aInCXgNMDw==
X-Received: by 2002:a17:903:124f:b0:171:4c36:a6bf with SMTP id u15-20020a170903124f00b001714c36a6bfmr23508754plh.0.1661907553806;
        Tue, 30 Aug 2022 17:59:13 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j5-20020a170903024500b0016efe8821a3sm10348174plh.89.2022.08.30.17.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 17:59:13 -0700 (PDT)
Message-ID: <9e093f5d-f9fb-1ed6-3598-5d4c46838a09@kernel.dk>
Date:   Tue, 30 Aug 2022 18:59:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [RFC PATCH] blk-mq: change bio_set_ioprio to inline
Content-Language: en-US
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1661852746-117244-1-git-send-email-liusong@linux.alibaba.com>
 <908d464e-e695-3a27-56f6-1ceabd727989@kernel.dk>
 <75f53b8f-30cd-23c3-1602-34d858302751@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <75f53b8f-30cd-23c3-1602-34d858302751@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/30/22 6:42 PM, Liu Song wrote:
> 
> On 2022/8/30 21:59, Jens Axboe wrote:
>> On 8/30/22 3:45 AM, Liu Song wrote:
>>> From: Liu Song <liusong@linux.alibaba.com>
>>>
>>> Change "bio_set_ioprio" to inline to avoid calling overhead.
>> Let's not try to 2nd guess the compiler here. Most things that are
>> marked inline should not be.
> Agree, I think there is something wrong with the commit log written here,
> it should be expected to reduce the call overhead, bio_set_ioprio seems
> to be appropriate to use inline.

I'm sure it's worth inlining, but did you check if it isn't already?
If it's small I'd fully expect the compiler to inline it already,
without needing to add things to do so.

-- 
Jens Axboe


