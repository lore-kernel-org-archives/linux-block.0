Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45282C18E5A
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 17:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EF021D7E
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 17:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZQzkv1fu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgCJRhV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:37:21 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42619 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgCJRhV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 13:37:21 -0400
Received: by mail-il1-f196.google.com with SMTP id x2so12747639ila.9
        for <linux-block@vger.kernel.org>; Tue, 10 Mar 2020 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h0+d0eT8j3D9V9+Zx4d1oKQcV5JrUFhrom1z+SABDyU=;
        b=ZQzkv1fuhdNWzNE9ifob6BaqbjKkH+6SvNYg3ZHUJWbXFc2R8Q8yfRGE79wig81mbI
         0L6uhUFunuYMloqncXL2v1cRg8PwRaoDMUUkmqkskmhVlcccgO/rb/5TFeFn2ieyc5di
         GMfxh6/HBCaccjioU6QPT1B1Oy4FWfObqxttf4IAutbqt70EwJqnnf8T4sP+9JWxW3Qm
         14tIcuh+2zL6Kpe8cY8/zRbLvSbNNgVKmVOvvOaU0sOywOSvdvs5y4xRyveDVIXeQyF3
         YjtjBFeb/ixJD9zhNf+jqdwNwCa/IxhX3QLZchV+Tjwd5ReRp6IFEGUBic/dF9D2wy3w
         008g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h0+d0eT8j3D9V9+Zx4d1oKQcV5JrUFhrom1z+SABDyU=;
        b=jNbY6174rOlXOQ/+rLSNkXnAYY85PhhDaI+iFA6UfrgiRFYT7aKDLyab802ShDYFe/
         W4CbTDxNCsvPrIsa2c8fubFPfM+HmZybXBaIFu9wyMB0Q/kJ8c/biGtc6bu2cNum7eTX
         wr2HJ3Jv0cUHabqI+nHq131dEhzNysnGmHVRoQtd0YVutjwRTDvh85AkbXr1NW+BkbhY
         vdwFMM2vjsXy1mpUXaSI/nhthmcjO2VzD/Q0NFcb4MRPLrQCNYemVh/fBF0TsdkK9Cr9
         RJBHJXWI8eZxrVX5D3prlBRbvF3SEtxb/jOuQA6eXKnsFJqQr0/Pyj2yF0kzL7CcWreT
         Lwkg==
X-Gm-Message-State: ANhLgQ13nciS3IqjWx92S48XrTgQioDq3Z+z8tWEFDUvaSRGbs3KNv0s
        BvK/5pLZe6nBAHTOePV4zvsOWQ==
X-Google-Smtp-Source: ADFU+vu4ZQEDYZQhLz6BySvD3vrhwTsXPiIoQaSW5wd/Cx6rry+V3kDO9EzE5KgAJKOXTnWygYgxBw==
X-Received: by 2002:a92:3d42:: with SMTP id k63mr20711214ila.219.1583861839332;
        Tue, 10 Mar 2020 10:37:19 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s82sm2523530ili.87.2020.03.10.10.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 10:37:18 -0700 (PDT)
Subject: Re: [PATCH block/for-5.6-fixes] blk-iocost: fix incorrect vtime
 comparison in iocg_is_idle()
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200310170746.GD79873@mtj.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e3980b91-7a43-2493-48d0-081ef4158d2e@kernel.dk>
Date:   Tue, 10 Mar 2020 11:37:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310170746.GD79873@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/10/20 11:07 AM, Tejun Heo wrote:
> vtimes may wrap and time_before/after64() should be used to determine
> whether a given vtime is before or after another. iocg_is_idle() was
> incorrectly using plain "<" comparison do determine whether done_vtime
> is before vtime. Here, the only thing we're interested in is whether
> done_vtime matches vtime which indicates that there's nothing in
> flight. Let's test for inequality instead.

Applied, thanks.

-- 
Jens Axboe

