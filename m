Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE5EC3A5A2
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 19:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D1622D6D
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 19:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfICTLl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:11:41 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37701 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfICTLl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Sep 2019 15:11:41 -0400
Received: by mail-oi1-f196.google.com with SMTP id b25so13705201oib.4
        for <linux-block@vger.kernel.org>; Tue, 03 Sep 2019 12:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=URWBJCKMLF9JrQV153//VBnnjZqNM/DWZOjYUVblmIY=;
        b=FmgXA1Qy4NeHcNt1G11ne002hvr8bj48ZHDxffh7SgP9mKYGqxB8fs8Queyf5IifsY
         2LGhH25UprSMxNra4ivQ0N9ZSDYwa0yQKM5u+mFm5VVEV6aXZXb9AxSf3RyksEOQOb76
         fsgwMW0k3qwBoHxKcFZf/vIL6mMXEwVdw8EpyX06LUF01f8S2Ev3O0Z5bOTUheeHg58B
         IcOmIqrPcG4Cnc1BXNZtYSzhGTrnOK6vAV475br0QfQJfDaqMMxWC1t8mSHQqVtMa7x/
         yl5im8sjjhbOjY4THpQ2t2WkrV6rIJm1W9DQXqqO6kp/8raUgq/ScbhsN/Yw7sW0WSvC
         Q/gg==
X-Gm-Message-State: APjAAAW5LkISn0r/ImuRKCra8VnUQbrb6xMFkZukmF+99BYIesWtWVPw
        kCZvV8DanmtWOtt/s05083E=
X-Google-Smtp-Source: APXvYqw2DmMHc5CE6UqqDkMZBdLNVpTfYTQiChaGEcROJ4Re4A9GNp3jUMs7eGed5eTqcfve2kcSJg==
X-Received: by 2002:aca:edd4:: with SMTP id l203mr683897oih.52.1567537900120;
        Tue, 03 Sep 2019 12:11:40 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id e1sm919082otj.48.2019.09.03.12.11.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 12:11:39 -0700 (PDT)
Subject: Re: [PATCH 1/4] block: centrelize PI remapping logic to the block
 layer
To:     Max Gurtovoy <maxg@mellanox.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de
Cc:     shlomin@mellanox.com, israelr@mellanox.com
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8df57b71-9404-904d-7abd-587942814039@grimberg.me>
Date:   Tue, 3 Sep 2019 12:11:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> +	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
> +	    error == BLK_STS_OK)
> +		t10_pi_complete(req,
> +				nr_bytes / queue_logical_block_size(req->q));
> +

div in this path? better to use  >> ilog2(block_size).

Also, would be better to have a wrapper in place like:

static inline unsigned short blk_integrity_interval(struct request *rq)
{
	return queue_logical_block_size(rq->q);
}
