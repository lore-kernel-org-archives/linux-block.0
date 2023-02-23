Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C0EC61DA4
	for <linux-block@archiver.kernel.org>; Thu, 23 Feb 2023 16:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbjBWQEh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Feb 2023 11:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjBWQEg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Feb 2023 11:04:36 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4BA4E5E7
        for <linux-block@vger.kernel.org>; Thu, 23 Feb 2023 08:04:35 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z2so13614054plf.12
        for <linux-block@vger.kernel.org>; Thu, 23 Feb 2023 08:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWBJJpfLbxHJ1BO+V07dvblOffLSc664lqCbo/zUG3o=;
        b=nb+OVzwomSctOUhThvUmOR2NlmDGFcwq8cza1TWz8E3LfhcMPPxcdw1NNU9rZ0aSmb
         m01LIL+Rz+e8c2LDjGr4FOLqp1jEDJjuuqycCfdOawPUgM2TK39nOj5d3hT4BTUBRFmX
         SkCEFiY5lyteAKcVFm09fTDfZCiCpRtjAW81OAAHUdO98fUIVP2xRqMCVlnmyemTONvO
         nbz4QlPKW+HYaE8OD4XZw37IPJcPt3DqzjE7prqAEcqPXZ5o0xS1mBU70Y5M3Ajrudej
         fxMZghivVYhEBjyZie4GYaz2cCcgdYytjSjAwYWZiVH3/fvGl0G95KFjnf2iUe0MLPK/
         PKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWBJJpfLbxHJ1BO+V07dvblOffLSc664lqCbo/zUG3o=;
        b=feS/kELft5WzxZ3B8F0oTucVsDla4wmqEkHAztqkwuhW6lg/9aFfC7OlsT24JY39IH
         rqScwDbIsdUEgwdYzh8Wp1hrYh2yVSX4voiNS/pE7PhHNN7/OvPttBlMizLd9xLUVS56
         hROmESqxpcuN2mHuS8suIjKp3iabMPgzVhNwI4bfr9q4W91JscNqv10u25ox6tM/xq1f
         VbwA+TqN2Lexg7wSgfs3YJtO08bmsl26qZDDcKUmbdz787dlQsVevx2qUX9MZrNZ4+CL
         eGrBXX2d1wHA2zj3QgJL6DD1pKPphJ7SjYBk0ItVn2JfgjU/kW5N5aCjdSp/tDDRu+Sf
         eK5g==
X-Gm-Message-State: AO0yUKXQF20s6/hhiDuXKKaR5RgklTYjjtvUO7UwlsGjlqrlnpmnBcE7
        cDKNHgkR45cfEonOdXowpWLO57lRJsa5XVEz
X-Google-Smtp-Source: AK7set8FUWAzS0RHvJ6iPvjFW5jpiDSUmBL6pJlKnGaoF9JksZsQhiJmEwf042gy9Zi9Rf2tS/pF3w==
X-Received: by 2002:a05:6a20:6918:b0:cb:7cc4:3ddb with SMTP id q24-20020a056a20691800b000cb7cc43ddbmr11699984pzj.3.1677168274239;
        Thu, 23 Feb 2023 08:04:34 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k184-20020a6384c1000000b004fb26a80875sm4931360pgd.22.2023.02.23.08.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 08:04:33 -0800 (PST)
Message-ID: <36c3acf2-dd51-f8a5-47d0-043848639cf0@kernel.dk>
Date:   Thu, 23 Feb 2023 09:04:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] driver core: remove CONFIG_SYSFS_DEPRECATED and
 CONFIG_SYSFS_DEPRECATED_V2
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org
References: <20230223073326.2073220-1-gregkh@linuxfoundation.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230223073326.2073220-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/23/23 12:33 AM, Greg Kroah-Hartman wrote:
> CONFIG_SYSFS_DEPRECATED was added in commit 88a22c985e35
> ("CONFIG_SYSFS_DEPRECATED") in 2006 to allow systems with older versions
> of some tools (i.e. Fedora 3's version of udev) to boot properly.  Four
> years later, in 2010, the option was attempted to be removed as most of
> userspace should have been fixed up properly by then, but some kernel
> developers clung to those old systems and refused to update, so we added
> CONFIG_SYSFS_DEPRECATED_V2 in commit e52eec13cd6b ("SYSFS: Allow boot
> time switching between deprecated and modern sysfs layout") to allow
> them to continue to boot properly, and we allowed a boot time parameter
> to be used to switch back to the old format if needed.
> 
> Over time, the logic that was covered under these config options was
> slowly removed from individual driver subsystems successfully, removed,
> and the only thing that is now left in the kernel are some changes in
> the block layer's representation in sysfs where real directories are
> used instead of symlinks like normal.
> 
> Because the original changes were done to userspace tools in 2006, and
> all distros that use those tools are long end-of-life, and older
> non-udev-based systems do not care about the block layer's sysfs
> representation, it is time to finally remove this old logic and the
> config entries from the kernel.

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


