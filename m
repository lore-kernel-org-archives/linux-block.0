Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A959C433F5
	for <linux-block@archiver.kernel.org>; Wed, 22 Dec 2021 23:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhLVX5L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Dec 2021 18:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhLVX5K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Dec 2021 18:57:10 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846CDC061574
        for <linux-block@vger.kernel.org>; Wed, 22 Dec 2021 15:57:10 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id c3so4944965iob.6
        for <linux-block@vger.kernel.org>; Wed, 22 Dec 2021 15:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Bnw7wHFCUHYpfW3nSmuDB+TIiRcPmrM94dEyYSAn7Cc=;
        b=6WhmxfTJP4YvSXjDC54AE6Qh8XgEIE+03YCRfh1sidSeeq0yEU5Mf7ge4UBw+SMmQ/
         kDHCNu5VTPZTbmKha9G2M6QzsOZDoIfIHGmE6vJ6WZ+MH375UO1iEcJiYYjbQfCrVl2F
         9AenqQlphhzyYS0GIfm0W+XFbsrnJj4yl84iLryPeyCCY2oz4W+S02hOE3EEdaTNqbUU
         gxRo0W6Y+gnUxMkiSl8rUAe26OQUS7Jf2bU76oBSSB10fctkZuIL9PeSNkCNi+0TkBkh
         NmmhfQDIATAdlAOv8WBXNYjCzZIy9RLC5pFR20ULBK4cy/uaeaNCDhNf6q98QtwAR88R
         Txtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Bnw7wHFCUHYpfW3nSmuDB+TIiRcPmrM94dEyYSAn7Cc=;
        b=0xs+Mw+UmP5m+fKQnYJj7negoL6uVP7Fa9E/rJzVBUA2ju5BO5n8NzaWPp6QzNiFSb
         MDX2cu0JNxsPAcgpSpqMJnrHP7q1xtDiCOajG9hXNM/Y/2HWvRgciZGbHPqmHhqRFuUX
         HQ62W2aWIdu6LmNiA4/WJOkgwPMVAcZy8lK8WeK8fY0yK84EhQSkyT+jGuouiFwaJKR4
         cznlmfqD+YdPdaWG5YXGXPDwEKB9ZW3q4dHMqebIMghO1jZk18c0RTVXFjr4pHs7Fg3F
         egZvDv1ijHqDzsor6ISybay1JMty+dgH6xRPNVIpSjIGA5BfZzt/BxD5fRNNB9cHLBZK
         VphA==
X-Gm-Message-State: AOAM533krQ+kFFsLYjWLc7st+QC78HljfnbIPjWbqrmLDWtUXYxuGpkd
        LV5VLesopSw4T9Dw+13L/PXnGYOmDuButw==
X-Google-Smtp-Source: ABdhPJy5zHj1ZVULmWmKPeo/mXMYhX8a9xoTE97n1lFacMU+agzi64Ee9hLUj2KRyB+huoCLoZunxQ==
X-Received: by 2002:a05:6602:2e8d:: with SMTP id m13mr29077iow.68.1640217429764;
        Wed, 22 Dec 2021 15:57:09 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id w19sm2509337iov.12.2021.12.22.15.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 15:57:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
In-Reply-To: <20211222211532.24060-1-rdunlap@infradead.org>
References: <20211222211532.24060-1-rdunlap@infradead.org>
Subject: Re: [PATCH -next] bio.h: fix kernel-doc warnings
Message-Id: <164021742879.719922.17581389641150829560.b4-ty@kernel.dk>
Date:   Wed, 22 Dec 2021 16:57:08 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 22 Dec 2021 13:15:32 -0800, Randy Dunlap wrote:
> Fix all kernel-doc warnings in <linux/bio.h>:
> 
> include/linux/bio.h:136: warning: Function parameter or member 'nbytes' not described in 'bio_advance'
> include/linux/bio.h:136: warning: Excess function parameter 'bytes' description in 'bio_advance'
> include/linux/bio.h:391: warning: No description found for return value of 'bio_next_split'
> 
> 
> [...]

Applied, thanks!

[1/1] bio.h: fix kernel-doc warnings
      commit: 6fd3c510ee4b37f2f9fe3d3cafbfa459e15c5e11

Best regards,
-- 
Jens Axboe


