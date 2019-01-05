Return-Path: <SRS0=xcXT=PN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F72C43387
	for <linux-block@archiver.kernel.org>; Sat,  5 Jan 2019 02:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A91218DE
	for <linux-block@archiver.kernel.org>; Sat,  5 Jan 2019 02:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="v8Y/D+1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfAECUJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Jan 2019 21:20:09 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:33185 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfAECUJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Jan 2019 21:20:09 -0500
Received: by mail-pl1-f179.google.com with SMTP id z23so18195138plo.0
        for <linux-block@vger.kernel.org>; Fri, 04 Jan 2019 18:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uUCV93Y9W4GXW5WnkPoHvx+D/agpVNJTKTE9Kq2BhCs=;
        b=v8Y/D+1wSU/0WPAfAEoz9gxLC3x0LfAE/qUWujUf+mxOpkJ7Wm+fFOwF88WdKGMkA7
         CRZ+lRa2H7056nLbzHN+ymhu9XTWtYsqjOTmvrSyZLzLLMTl84XfrC72KAGDbGbIzh7C
         Lb+w6IqaY+M/LXHukMYvA/AjR5j1R3tlBcVGEDyoISFVwJ4dS6pbDQs/xiUgEy4eeUQ+
         vb7ln5vfk+XsVT61hJ6nIaTi4ImALgeo5fp+Zo5OXd1bhF8tE/pKH6pOQ5cBbZjFxtUZ
         DD4qDDrL6DMseAIRFYeRkuSC+pVrSayxcFKrMK4tzLK4fAIN+3agzc5BVIvW2AVaOta0
         kcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uUCV93Y9W4GXW5WnkPoHvx+D/agpVNJTKTE9Kq2BhCs=;
        b=bF9OfQyu6a1UBRxdfUCEnLlk2RdnefyCQGQXNVO4Eug8mLZTccvq+PAXHR8drQxRTe
         8+Lvo2ktw3an/BlhA+daN8Pm5qN+KTd6jT/GQCa2XOTpTWfYCJsZscEWRwsqzpJhSOuV
         4Ptg+qZon7NeNmfWVnBxuJF6uctGOjiwKxmyiJgNe4JN0Fb7AUbsrdAjC3Gk/8P2bvWW
         SepHDWGkgvZ5FikBGmoUfqfDPeI16mEOGTPnxOHgyX7NAKnmq6ztJ+72HhyWVueDa10w
         RGNn8fmJHN+qRL+GBCSwoiscbPA1Q3dFzhs65+pDUMQphrgXnJKCMirq5qgAWvG11Tgl
         BBVA==
X-Gm-Message-State: AJcUukcV/1kzAu0idyFZmFhR1/f+K1OMCTvY/vh9CaTnrNzl1GgWnxkT
        rUPfJIX9BwX3C2IyiaVbwjbzEUxz0oVB1A==
X-Google-Smtp-Source: ALg8bN68UvPisj+rL81ogAAOzO3mpHaDZsfw6Br2Ui5UZpMaCqiaJa8BhMMNgegv8QgH8RRS9DT4gg==
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr51296410pla.144.1546654808001;
        Fri, 04 Jan 2019 18:20:08 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id j21sm84330880pfn.175.2019.01.04.18.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 18:20:06 -0800 (PST)
Subject: Re: [PATCH v4] block: add documentation for io_timeout
To:     bvanassche@acm.org, hch@infradead.org, linux-block@vger.kernel.org
References: <20181226035613.GA16642@192.168.3.9>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f4179d96-7de6-07eb-99fc-d748312ee498@kernel.dk>
Date:   Fri, 4 Jan 2019 19:20:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181226035613.GA16642@192.168.3.9>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/25/18 8:56 PM, Weiping Zhang wrote:
> Add documentation for /sys/block/<disk>/queue/io_timeout.

Applied, thanks.

-- 
Jens Axboe

