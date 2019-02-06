Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E982DC169C4
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 13:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D4420B1F
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 13:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="2Qsg1ERD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbfBFNlE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:41:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41233 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfBFNlE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Feb 2019 08:41:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so2898048pgq.8
        for <linux-block@vger.kernel.org>; Wed, 06 Feb 2019 05:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cHfn0jY7aIzvbK2BJ7kPV6nGwOUL2bvT6pl6qTPl9iM=;
        b=2Qsg1ERDhllSank5OeXngcjrmmjNNDL/nQtfPWTXNxiK8/1bFwZCtytKp8NCWaSBo4
         Wi9o3I9bJsUqFA74qaBwBXVf/mvNpspSKBubpAL2nHgf4hGcqMhwlRJ37FDcRlPeiws0
         gaZ6BsSIKVOWrDu512Md6FYaS/KS5GwQeh7OJUNsB6VcYDGdUrTkiQB5fAF9hG7oPoXL
         Ryk4iKnJQNa/4BLr7GHvu2fQMF1sDeIcGdAtQoz5zVRr1LJVSHxT/es0tvv1c9nlaJxp
         mkpdwJVrPIZeXGesIUkezqvKSGL+Tz4oVEGn8WI+FRISh1UIRMuJygk4WcJCTHqfCZj3
         yUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cHfn0jY7aIzvbK2BJ7kPV6nGwOUL2bvT6pl6qTPl9iM=;
        b=Os89P+8VWdZDDybKI6zgql5aKacHvqEzDR8nhu1xld2XK6GC1Kt87N9y94DdRHRFTD
         uoHDi6til/SOlawC/kSFZvXBW+zvJP93V9SbcHhkjxx/8YWtuEKVPm45hWCI9Qg0DIb6
         pG0Jr6nOZR4BzsSPgcvaxMOUd94Ixnb1CloiGNSEuZ/SN3tJYqP78ZBHgvsdIzbgxJBY
         kfqgGFFZbuDOzPlj87mMqsVHBOcoIuy+1zgKMLiPYaqKkztRBhArWB7SSBPxD4MwMIxQ
         l5ZKWWCVBYAHjg95v44yR2l0M2l4AR39QRtLJzP6jz4MqMwhXeTdZBIQklol2Z1CbHwI
         Aofg==
X-Gm-Message-State: AHQUAub8jqm3Cb5q8SR7YfdYnNRn1zj+jW6LhJjh79O9p3EWSQXzaOSf
        stQxfM5Ok0q6E3JcF9lwQLxmtg==
X-Google-Smtp-Source: AHgI3IYtStd3/KmHkTxiHcYLBUGKu3jii6dcSlcbc0E76FPssBB+HC0HFAOkv5q+7Xr0oML2TkzuyQ==
X-Received: by 2002:a63:6cc8:: with SMTP id h191mr9366740pgc.366.1549460463668;
        Wed, 06 Feb 2019 05:41:03 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id o13sm8503714pfk.57.2019.02.06.05.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 05:41:02 -0800 (PST)
Subject: Re: [PATCH 13/18] io_uring: add file set registration
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jann Horn <jannh@google.com>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        linux-fsdevel@vger.kernel.org
References: <20190129192702.3605-1-axboe@kernel.dk>
 <20190129192702.3605-14-axboe@kernel.dk>
 <CAG48ez2kLWUEambWesQQaeVn_u=PtjuMeDUc49yamhYspfd7Sg@mail.gmail.com>
 <20190204025612.GR2217@ZenIV.linux.org.uk>
 <785c6db4-095e-65b0-ded5-72b41af5174e@kernel.dk>
 <2b2137ed-8107-f7b6-f0ca-202dcfb87c97@kernel.dk>
 <40b27e78-9ee8-1395-feb3-a73aac87c9a7@kernel.dk>
 <20190206005638.GU2217@ZenIV.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8f124de2-d6da-d656-25e4-b4d9e58f880e@kernel.dk>
Date:   Wed, 6 Feb 2019 06:41:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206005638.GU2217@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/5/19 5:56 PM, Al Viro wrote:
> On Tue, Feb 05, 2019 at 12:08:25PM -0700, Jens Axboe wrote:
>> Proof is in the pudding, here's the main commit introducing io_uring
>> and now wiring it up to the AF_UNIX garbage collection:
>>
>> http://git.kernel.dk/cgit/linux-block/commit/?h=io_uring&id=158e6f42b67d0abe9ee84886b96ca8c4b3d3dfd5
>>
>> How does that look?
> 
> In a word - wrong.  Some theory: garbage collector assumes that there is
> a subset of file references such that
> 	* for all files with such references there's an associated unix_sock.
> 	* all such references are stored in SCM_RIGHTS datagrams that can be
> found by the garbage collector (currently: for data-bearing AF_UNIX sockets -
> queued SCM_RIGHTS datagrams, for listeners - SCM_RIGHTS datagrams sent via
> yet-to-be-accepted connections).
> 	* there is an efficient way to count those references for given file
> (->inflight of the corresponding unix_sock).
> 	* removal of those references would render the graph acyclic.
> 	* file can _NOT_ be subject to syscalls unless there are references
> to it outside of that subset.

IOW, we cannot use fget() for registering files, and we still need fget/fput
in the fast path to retain safe use of the file. If I'm understanding you
correctly?

Just trying to ensure that I understand what you're saying here, as it seems
to refer to the file registration part, not the main patch (which did get
reworked, though).

-- 
Jens Axboe

