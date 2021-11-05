Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BAEC433EF
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 02:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFBDD60E97
	for <linux-block@archiver.kernel.org>; Fri,  5 Nov 2021 02:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhKECIz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 22:08:55 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15363 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhKECIy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 22:08:54 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HlkPk4wCPz90qj;
        Fri,  5 Nov 2021 10:06:02 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 5 Nov 2021 10:06:03 +0800
Received: from [10.174.179.189] (10.174.179.189) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 5 Nov 2021 10:06:03 +0800
Subject: Re: [PATCH 0/2] add error handling support for add_disk()
To:     Christoph Hellwig <hch@infradead.org>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linfeilong@huawei.com>
References: <1636014799-20156-1-git-send-email-wubo40@huawei.com>
 <YYOdxHEklLAIwNwo@infradead.org>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <a4ae38f0-6e81-9833-64cc-9053ae0d917a@huawei.com>
Date:   Fri, 5 Nov 2021 10:06:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <YYOdxHEklLAIwNwo@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.189]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/11/4 16:45, Christoph Hellwig wrote:
> Luis has an outstanding series that also covers these two drivers.
> .
> 
OK, Please ignore this patch.

Thanks.
Wu Bo
