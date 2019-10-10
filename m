Return-Path: <SRS0=jW7Q=YD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D66C10F14
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 20:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439CC206B6
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 20:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfJJUnT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:43:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54944 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfJJUnT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 16:43:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 653C128D353
Subject: Re: [PATCH v2 1/1] blk-mq: fill header with kernel-doc
To:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, kernel@collabora.com, krisman@collabora.com
References: <20191008001416.12656-1-andrealmeid@collabora.com>
 <16a10539-c0a0-e411-8f9a-1f0830579986@acm.org>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <2408cae2-94bf-0b1e-9a87-e4303f44fd68@collabora.com>
Date:   Thu, 10 Oct 2019 17:41:56 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <16a10539-c0a0-e411-8f9a-1f0830579986@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Bart,

On 10/8/19 3:12 PM, Bart Van Assche wrote:
> On 10/7/19 5:14 PM, André Almeida wrote:
...
> 
> Bart.

Thanks you for your extensive and detailed feedback. I'm applying those
changes for v3.

André
