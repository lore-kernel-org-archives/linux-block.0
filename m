Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A30EC04EB9
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A2720850
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A2720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbeLDBLs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:11:48 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43451 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeLDBLs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 20:11:48 -0500
Received: by mail-ot1-f68.google.com with SMTP id a11so13568257otr.10
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 17:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J+rMGA97/B2G9/U7bW/KT5QBRAhBn0Ahj4c2lXgk94Y=;
        b=MOtlHQy8V869dwXRR8BKVnLV7WbdmMSUVzT1m/7T2oWeaSLG674ywZa4Z3s6udqex/
         JHCxujaOkiFDrgShjojePrLeJ35ceQjf5+TWHj+EjchvFMjblAZ/Ow79UepVk40fmjYY
         VLLo257BOdCp7SqHV45IpVfNdJ824Q588EN+GrY0AkRmMojklVEgEjtkWPF/CIv08wed
         Bpic0/W2HxOrXUkitxrTRLcCVoHosPkW1xXdBXGQpKD74xgShZviznrxrjxLu9ZF6CD9
         eLUNUG7c1utA6h/3N7oyIe8prxvv1RREENeA10DiMmLVIzPDW24kCvxZNreq3pKEUg3N
         PHgg==
X-Gm-Message-State: AA+aEWZcMDPRLGCXyh/bjKF22cmRRj1vt3Ip+zijZSoJfUTE3KMALXgj
        oySZegMP7jGylXy+b6CsFyZE2BvS
X-Google-Smtp-Source: AFSGD/Ul0b2wTz4G2ph1sOMQ23JeU/bwPTz/jhFdsqzrV/PuVga8tPPTy9E3/Sb/TCtKLrOKV3bzvA==
X-Received: by 2002:a9d:4549:: with SMTP id p9mr10966066oti.51.1543885906579;
        Mon, 03 Dec 2018 17:11:46 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id r9sm14762842otq.81.2018.12.03.17.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 17:11:45 -0800 (PST)
Subject: Re: [PATCH 10/13] nvme-mpath: remove I/O polling support
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-11-hch@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f62ed781-28cd-dae0-f3aa-544d75cdc4fc@grimberg.me>
Date:   Mon, 3 Dec 2018 17:11:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181202164628.1116-11-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> If it really becomes an issue we
> should rework the nvme code to also skip the multipath code for any
> private namespace, even if that could mean some trouble when rescanning.
>

This requires some explanation? skip the multipath code how?

Other than that,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
