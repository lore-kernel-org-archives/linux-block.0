Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBCAC43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 14:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2261F20883
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 14:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="w9NHg6d0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbfAIOj1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:39:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33003 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731479AbfAIOj1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 09:39:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so3771326pfb.0
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 06:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qLWFgPGUlL4hfkQh3qWtVmtFk7lmuoGc171l0OAh9mA=;
        b=w9NHg6d0zKFuexv+kYsSm3ANBPdNxIbZ829pc2zxR9zPWoZbzdCUyZGOF4KWk+HvkP
         2s6Uz7xIUP6ZGdimwD6lCtpAhddhIzaImxdoL/XWlhwyfGfkvjHET5XzvZi9RUzNOP8W
         ldEkNvhkj7uO8Mttxzb/zitMyL74gTlPsVneNGp76Bje7f/GQS1LjMTgZ1PdakKg/64C
         UsLeKWlluM27RUHSY/ZyIyl/U5uUhGvFjivEs8bIArqfI2lqvrn1XxqqHKHtSybAbT9x
         Vpk1BDkKHvmyJGW0hWjusYvmQFzQpaufsd2hB+4WZogXNWhyHoSvZ4H2X3/EX3c0mbqK
         YnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qLWFgPGUlL4hfkQh3qWtVmtFk7lmuoGc171l0OAh9mA=;
        b=orkp28dyhn5+csISTG2uj5MpMlcS+8Uau07l3mo7zJvCQ37ScGc2ilPZrdhvxffInU
         id8TrZhtzEsrEZjgguMLj+Xzh25LVxphcju1SegvSW/703YstjQ+i6yx1ZxavWtrdj7e
         5GvUaG/4a+HUb5rVQDrrbFgcfW/Iwb28HbqqUHojsprt3CCtTeofy+u2/YPuJ2W2iRIM
         qDaS8941xgIPtQHrk89vc1AGWoGzqfKhPER0lThUgg58ZvTuNPMDU1vcR42opPi2VTiR
         YXvw/YMVJZXjhJiY4ALNj9nh7svSUWz0l2BHTrZMuUwzx5HCGiTW8GYfEbAoSkY1HUpV
         w47g==
X-Gm-Message-State: AJcUuke1f09qGpZ9pK5fqUcblOLfMA933Ji17IfleUpujuCGCBGZvdcO
        2GqKAbVGobzQpBixbhIz9vcwCw==
X-Google-Smtp-Source: ALg8bN66Bk8ILVOgAgNbYG1G3N00r9IVre5PBAf1GNBSqUCj2vI1BaL72XeRnlqg7+Tsojy+sNzMhQ==
X-Received: by 2002:a63:1c09:: with SMTP id c9mr5571841pgc.200.1547044766386;
        Wed, 09 Jan 2019 06:39:26 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 196sm285428795pfc.77.2019.01.09.06.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 06:39:25 -0800 (PST)
Subject: Re: [PATCH] block: doc: add slice_idle_us to bfq documentation
To:     John Pittman <jpittman@redhat.com>, paolo.valente@linaro.org
Cc:     corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20190108215613.15277-1-jpittman@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <64f1bba8-1a6e-5aa0-3357-edfdcd7de574@kernel.dk>
Date:   Wed, 9 Jan 2019 07:39:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190108215613.15277-1-jpittman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/8/19 2:56 PM, John Pittman wrote:
> Of the tunables available for the bfq I/O scheduler,
> the only one missing from the documentation in
> 'Documentation/block/bfq-iosched.txt' is slice_idle_us.
> Add this tunable to the documentation and a short
> explanation of its purpose.

Applied, but I fixed up your commit message. You should use 72
chars lengths.

-- 
Jens Axboe

