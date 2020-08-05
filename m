Return-Path: <SRS0=yU/V=BP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE98C433E0
	for <linux-block@archiver.kernel.org>; Wed,  5 Aug 2020 19:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C712068F
	for <linux-block@archiver.kernel.org>; Wed,  5 Aug 2020 19:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgHETRV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:17:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35024 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbgHER7v (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Aug 2020 13:59:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id f1so41000291wro.2
        for <linux-block@vger.kernel.org>; Wed, 05 Aug 2020 10:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Xfr80AqzucZQwBQ+/F+gOUpjpsSV020pySmbLRu/yw=;
        b=DzzyVJYzkDo9ws/aRFQ2iwVV/J+YKFSbajUisGuuYLB5hHiBY2GOzwH/XoAjofArRN
         0aJBDXtV19Edg2saZdCN5mCqPQjvJDRTHOFD7fS8O88H3PeoArdVBp6mBbUC2ej0AhPO
         6Ly1r5HelpWMhTpdVxgarr1O+m80K/7YcIUWPaKNL9d2fljdRs9E7ce5HUe39Mk9pZht
         Qpkm/P2LXhAdF9i++ZZXpzxMzf7AEaXyUwoCrr1kwTtToT5jFv4LbypNV2LiqOPhj/JE
         5U3RlMhzmesfktTecmVRkb4Z03VFqhu6B3zdZD25fgJQrdO41mp4ZSLXs5XmsUWp060k
         J/aQ==
X-Gm-Message-State: AOAM532q5dtp7TN/AVqgGL/hwXK47bDFVAXOCRof7M3UnGBIywcABRgb
        R7b197Bv4u4dUtQKF/nHJ1o=
X-Google-Smtp-Source: ABdhPJy9KlX1hIfSp30xvwI//ewlrBSnCuyeI/ge0ZLoovlZPzFkG+KlPlEfTGMy4wJRBlLGWlGjDw==
X-Received: by 2002:adf:ed0f:: with SMTP id a15mr3823250wro.341.1596650388332;
        Wed, 05 Aug 2020 10:59:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:2803:3684:5e52:5417? ([2601:647:4802:9070:2803:3684:5e52:5417])
        by smtp.gmail.com with ESMTPSA id s131sm3728576wme.17.2020.08.05.10.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 10:59:47 -0700 (PDT)
Subject: Re: [PATCH rfc 6/6] nvme: support rdma transport type
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200803064835.67927-1-sagi@grimberg.me>
 <20200803064835.67927-7-sagi@grimberg.me>
 <6edfbfd4-106e-f200-2783-d59615f0a84c@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f29fc615-a5f7-a160-f33e-d84aca03d639@grimberg.me>
Date:   Wed, 5 Aug 2020 10:59:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6edfbfd4-106e-f200-2783-d59615f0a84c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> # nvme_trtype=rdma ./check nvme/030
> nvme/030 (ensure the discovery generation counter is updated appropriately)
> nvme/030 (ensure the discovery generation counter is updated 
> appropriately) [passed]
>      runtime  0.616s  ...  0.520s 460: unload_module: command not found
> 
> The unload_module[1] was defined in [2], how about move the definition 
> to [3],
> 
> [1]
> _cleanup_nvmet->stop_soft_rdma->unload_module
> 
> [2]
> ./tests/nvmeof-mp/rc
> 
> [3]
> common/multipath-over-rdma

Right, I had this change locally:
--
diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 676d2837fb06..e54b2a96153c 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -457,7 +457,7 @@ stop_soft_rdma() {
                                 fi
                         done
         )
-       if ! unload_module rdma_rxe 10; then
+       if ! modprobe -r rdma_rxe; then
                 echo "Unloading rdma_rxe failed"
                 return 1
         fi
@@ -469,7 +469,7 @@ stop_soft_rdma() {
                                         echo "Failed to unbind the siw 
driver from ${i%_siw}"
                         done
         )
-       if ! unload_module siw 10; then
+       if ! modprobe -r siw; then
                 echo "Unloading siw failed"
                 return 1
         fi
--

I'm not at all sure why the retry mechanism that unload_module does
is needed at all...

Bart?
