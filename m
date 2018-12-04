Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE65C04EB9
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 00:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40C82146D
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 00:56:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E40C82146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbeLDA4Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:56:24 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39230 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLDA4Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 19:56:24 -0500
Received: by mail-oi1-f194.google.com with SMTP id i6so12771485oia.6
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 16:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=hQPVnuK3NIJIZiOaKekRKbAKaJjvohEHfgugPl0mymxbDSrtpA28XVGpOnfnmNUmab
         yGcjPTBB4agFt/pdkATjvDg6sreJy0SRYc1CNY9ykZmmeo6rS6nbD4krxO54Z+Pru2Kv
         0egHpuqNtqb4wIiKCBzfWwiexNEDYIytzki1laN0dha5NeOa4pZY1QtzHm/BVZSyAQVO
         ykK1YsUHZCBBzwv9iGotefXWsR1yr7g8tPLuqGxSt0BLV4qB7CffmS9E/33W0+T58bNZ
         2fPK1biy1JzrQFZOxodZ6cFmGrI6r1LBXXbrK0nI4CCt0h5COoEQGqdtp7k3sEMrOojK
         zLeA==
X-Gm-Message-State: AA+aEWakA5PpPAjAamwn2P9Z9WoNBM3rk0yte33lQScFoYA5MbF0/ZPV
        mkFsGvOvgKOgSsVfD49Ebui2bTol
X-Google-Smtp-Source: AFSGD/WKDmQDfCPuFOqVQMqEaGaJxY5OkCVkqTy1W3e7KuaDS/EtLZdvpxzKIkMjFEKYXw306HiulA==
X-Received: by 2002:aca:3d42:: with SMTP id k63mr11595571oia.95.1543884983120;
        Mon, 03 Dec 2018 16:56:23 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id t12sm7435319otk.61.2018.12.03.16.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 16:56:22 -0800 (PST)
Subject: Re: [PATCH 04/13] nvme-pci: only allow polling with separate poll
 queues
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-5-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f86a1a33-d635-4455-c1d2-68744c4f7cff@grimberg.me>
Date:   Mon, 3 Dec 2018 16:56:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181202164628.1116-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
