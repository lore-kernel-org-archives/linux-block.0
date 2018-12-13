Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13525C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD06720870
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UuS8G4uL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD06720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeLMUB2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:01:28 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:44167 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeLMUB2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 15:01:28 -0500
Received: by mail-io1-f54.google.com with SMTP id r200so2588879iod.11
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 12:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9TVsgiY0h4P9NBJabi0jMS+k2JEdeYxZ8IllZyQ3Uzs=;
        b=UuS8G4uL9HIUucf67w7Vd723NJ+yFez8R0xtL3+FSOF6QAMtKsM3qstCGYlSmmBE8p
         XL/ybOqO/vz4fLvNjBL+EyziQeFtgMFb6QAkkA9adD56hXgaIzoH8oo+kXKB3e6OeTC0
         YysDQN/hf3Ig4aYusxPjsD+283iNqJa2ZinZYyQcPmo1wVHSIbwnUShhm2oFP4lZ5SN9
         lvTSCJHAhAhvfJochSAkFPdR8e/SNc0/6vkGgxlecOIaymDvsrZjEAmeFVzf3L79ygJB
         6oB80W7yWG0E6WmRlrN/L65mz02QstXhX6lEr0TVvhif8fPQfjnE0rCkBXQCNuiEwj92
         omXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9TVsgiY0h4P9NBJabi0jMS+k2JEdeYxZ8IllZyQ3Uzs=;
        b=efnLgbDZoaB1TnSxVtEqLDv8DEWNQ3YyKyIZW+zjah8P9V94Ns+wWp7Tkg7Fg24lU8
         7dAfPq81yTC4cDdrQcP8E/28qE4O+ujFjBiF6sayWaubiWUVN4TSCtcMY9JWFfrIw8iX
         myItdmPzqPntnIzqfTF0ybPW2ZaPK6aHJ7R2awTqXkYTD04dA/q3ptcC+gRqNTFa91ji
         DIulS/1HwUVOJqnRYgNtZMv5suK/YSyP4NUyTWRBIOHedOCDWw4zta4dEL43oDPiHkn1
         2cTWRArsEtxPoMgqHwf5B2023vY97qPT+shb4nmyQFImIYoptspXpMFG/MVNMtXr7tAb
         tXcQ==
X-Gm-Message-State: AA+aEWamKC0JyQRCEJ+rxtxjsaISGloJ9DGHJKNJVAMxoK8g4aYY2k8I
        Lyd9dIm/tVPikChoTjEWb7lEKDQXhbSHTg==
X-Google-Smtp-Source: AFSGD/XXnTnWbUrhA1OcstdpJJFVBiWanPLKJr+U7NUAA7a8pxpo5qagq+it8Sv6kSlozad7SM6/aQ==
X-Received: by 2002:a5d:9b0d:: with SMTP id y13mr111319ion.243.1544731287131;
        Thu, 13 Dec 2018 12:01:27 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t1sm1291152iol.85.2018.12.13.12.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 12:01:26 -0800 (PST)
Subject: Re: [GIT PULL] second batch of nvme updates for 4.21
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20181213195607.GA7751@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7fb2a1a7-5aa9-3a06-6418-76c6a1f2a474@kernel.dk>
Date:   Thu, 13 Dec 2018 13:01:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213195607.GA7751@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/13/18 12:56 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> here is the second large chunk of nvme updates for 4.21:
> 
>  - host and target support for NVMe over TCP (Sagi Grimberg,
> 	Roy Shterman, Solganik Alexander)
>  - error log page support in target (Chaitanya Kulkarni)
> 
> plus small fixes and improvements from Jens Axboe and Chengguang Xu.

Pulled, thanks.

-- 
Jens Axboe

