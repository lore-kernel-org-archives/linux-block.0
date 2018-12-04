Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD30C04EB9
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809B12146D
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809B12146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbeLDBfm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:35:42 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:41800 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeLDBfm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 20:35:42 -0500
Received: by mail-oi1-f172.google.com with SMTP id j21so12838387oii.8
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 17:35:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=qk7ar9+ypyWOImIwodKqoF2FFvOkbz8omFbEOZTHIBoWYBQKxO/S/w5pt/SX+IbPzN
         j3V9dTR1rB953PBidj+nRPsWg+peNLo/6ohQAamxPXRjdwD6VHsot38MaZaROJpvfnDR
         RVPDy5tKdxudHJzzxKOp4mz5ltLYWnNim7gaGukMx/XI8Q5WTTkGHX51kWT4A1YM/9m8
         qufs6jTcM2BtdJPA1Oynvk+m/YYEdpHvNuP4wing4nawkuT/V4nz2jeC8MPyrCPSe5aE
         4A5GKEBhlzDgwIlcSYaxg7PsaQEquXbIRM8RvUp5sdMBkNnwa8eWaFUlMw9c9dtMVpgV
         iwxg==
X-Gm-Message-State: AA+aEWZe3ctfzivhIogcjnl1CrOCKXUz+Xog2wGb1Cc/uYCsecqvKHSD
        qpo18tcUFaugQ2c3cxbQN0g=
X-Google-Smtp-Source: AFSGD/XWZhKPDNR9ca5KdsQ6eMVHYd6QetlRMGGz1LLbyIhGp3+L3L0l20gdk2Lc91j3lVoe4nNBnA==
X-Received: by 2002:aca:1e08:: with SMTP id m8mr10830703oic.347.1543887340940;
        Mon, 03 Dec 2018 17:35:40 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 52sm28284416oti.30.2018.12.03.17.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 17:35:40 -0800 (PST)
Subject: Re: [PATCH 1/7] block: improve logic around when to sort a plug list
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-2-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <47f01bcf-a6c3-a366-da7d-b2cbc04b7ebb@grimberg.me>
Date:   Mon, 3 Dec 2018 17:35:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128133538.20329-2-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
