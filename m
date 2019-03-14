Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E7BC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 23:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA99221873
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 23:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p+7/XqVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfCNXt6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 19:49:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48424 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfCNXt6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 19:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pDx0F0b/cwlQ8flBSxOnlEDXSq4rrGSdcWydb6YYey0=; b=p+7/XqVoIf+C8N4dV6O1cZ+Iz
        fdY9KXz/cjkLvpwflu7nfZ6yiDgK9uCPdtz0j8Jqi1rX3feklRyz8mFE6uqdCz7BN3swAT+TQILEM
        to0uT/ntftd6241U7oUOMqm9WHMdMP6+Avp0qs9rbZx2mSp39SPUrRFXGCfmv06IYB1Eist2+7JVb
        AjTaK2OQTT+puXdoVfDhoA2lSAVRUyKzS8eeu5iXFyqaHtJf0BPMkhhlsnTrUBglRTMxb1bS1t+Ep
        O3JymfExqVheUEECeZkCYbVYDo1lg8+jXsSm/qZMo7FIT2XLQNbZFMhttzagr7pHVp+40kQChBAcV
        04LdDfx5g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4a6l-0005ay-QW; Thu, 14 Mar 2019 23:49:55 +0000
Subject: Re: paride/pf.c: blk-mq use-after-free (kernel v5.0)
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org
References: <30c63b2d-92d2-51be-40f0-62cada110388@infradead.org>
 <7d24a06f-f219-e50a-e8f8-915a6cc1b796@infradead.org>
 <e2a66da2-5433-5b42-1ebe-9f1c135b5471@infradead.org>
 <59cb035e-6880-de5a-33c5-d4db6ed910f4@kernel.dk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4a2adc33-ef38-6a5f-65ee-8fcfaa0948a9@infradead.org>
Date:   Thu, 14 Mar 2019 16:49:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <59cb035e-6880-de5a-33c5-d4db6ed910f4@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/14/19 4:43 PM, Jens Axboe wrote:
> On 3/13/19 5:09 PM, Randy Dunlap wrote:
>> On 3/11/19 6:34 PM, Randy Dunlap wrote:
>>> On 3/11/19 6:25 PM, Randy Dunlap wrote:
>>>> [Has this already been addressed/fixed?]>>
>>>
>>> Same bug occurs with paride/pcd.c driver.
>>
>> This still happens (in blk-mq) in v5.0-11053-gebc551f2b8f9 of Mar. 12, 2019,
>> around 4pm PT.  [caused by paride: pf.c and pcd.c)
> 
> I'll take a look at this, been busy with other stuff. How are you
> reproducing this? I'm assuming you don't actually have any hardware :-)

Right.  I just load the module (pf or pcd), unload it, and
then load it again.

-- 
~Randy
