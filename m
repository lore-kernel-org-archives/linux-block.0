Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C7BC54FD0
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 16:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F186206F8
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 16:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WHNqffGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgCYQVO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:21:14 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:42715 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgCYQVN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 12:21:13 -0400
Received: by mail-pl1-f169.google.com with SMTP id e1so979233plt.9
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2020 09:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9w7AiaZ0I1Kr1hFPHxWeGuVfiO+BvfqSfTlRt8g9SjY=;
        b=WHNqffGZhqk8UR+uLFGk50QXSaMCvhjuqIe5K5NhimUpbSLu0Luo1Sfe7HvKR66Ic5
         C5YDEWi6Vq2i+hSpJ6145Hrh+nvPpJe9ZL34aAUfYLP1d5Nh72vlEpIw83p/rWaywRya
         YMIGawflr/hBBD/GeyMFWAB9ERAcGww5UpEqyMjOj58Jz/cEY2lkiQrX42pPev50fEQz
         fli1YEs147V8ZyN203Jv/8DZye68DGpccX3eQpmoe8Vk2IEIqf5EuQVVF1Y2qx5IqXog
         TmIn34JRgGU+jHyAPlCzFIYyIu26dGmbf0ZRIzE1KLWt/5srIdVyONtLFqAZoWOAbuq7
         9NUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9w7AiaZ0I1Kr1hFPHxWeGuVfiO+BvfqSfTlRt8g9SjY=;
        b=WMr1Vawy3ko8AtDtsKtsRijAK/qAccsKvG8stHx52fSjbELAVUHz9pbVKgfjpnmwFO
         4JLL2Dl/psx6CBpoPzVKDeYRas2r0eaf9xdqhiwBTAl7WI3692edgUwD0xBud8hLXx3I
         5LPes02ooBnW4Kd8ghoPJWJPCPfNUeozNE5dTZCH54y/kohFy7oBhC6DffZakj1bQ/en
         fy/P5bi+lW6K3jaZStODgccqKEaHlNo+MHsmJK/tAcJhDLWFKTfTmsHqsKME4KMvXykr
         LNkblS9B8D29aH8i7VKw2T1YOFmvZQ+YfoUwNwHf9KLLTOMib+834wnenx1P6Lu8z/3w
         uxcA==
X-Gm-Message-State: ANhLgQ0LM9Z8hzkS2eSCp3sNv0vt4O1b/APpnkRpbHkMmquNnG6SppAS
        fvQzz35DXhi6IOp3gZfHp2WMSg==
X-Google-Smtp-Source: ADFU+vuiKPochloItwc/nZUksJU3th/kYXuHqdmzB8RotXh71Ew1ry1CxHJl9LOqDTxqGjOiirpJuA==
X-Received: by 2002:a17:90a:930e:: with SMTP id p14mr4534381pjo.159.1585153271543;
        Wed, 25 Mar 2020 09:21:11 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id m11sm4816006pjl.18.2020.03.25.09.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 09:21:10 -0700 (PDT)
Subject: Re: decruft genhd.h v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200325154843.1349040-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ab5d4f34-40d3-44c5-10f1-37841cc7e5be@kernel.dk>
Date:   Wed, 25 Mar 2020 10:21:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200325154843.1349040-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/25/20 9:48 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series tries to move as much out of genhd.h that doesn't really
> belong there.
> 
> Changes since v1:
>  - rebased to the latest block tree

Applied, thanks.

-- 
Jens Axboe

