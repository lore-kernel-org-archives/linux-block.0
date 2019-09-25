Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DA4C432C1
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 07:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9930E21D7C
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 07:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442448AbfIYHFu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:05:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39286 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442434AbfIYHFt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Sep 2019 03:05:49 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91DFA308FBA7;
        Wed, 25 Sep 2019 07:05:49 +0000 (UTC)
Received: from [10.72.12.58] (ovpn-12-58.pek2.redhat.com [10.72.12.58])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C85F819C70;
        Wed, 25 Sep 2019 07:05:47 +0000 (UTC)
Subject: Re: [PATCHv2 0/2] blk-mq: Avoid memory reclaim when allocating
 request map
To:     Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc:     josef@toxicpanda.com, mchristi@redhat.com,
        linux-block@vger.kernel.org
References: <20190916021631.4327-1-xiubli@redhat.com>
 <20190916090606.GA13266@infradead.org>
 <8c08e9f8-cf71-8fcc-cff3-0d92dd859a59@kernel.dk>
 <20190918163826.GA14377@infradead.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <db3b6bda-3764-ccd7-ec49-a6202796745b@redhat.com>
Date:   Wed, 25 Sep 2019 15:05:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190918163826.GA14377@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 25 Sep 2019 07:05:49 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/9/19 0:38, Christoph Hellwig wrote:
> On Mon, Sep 16, 2019 at 10:52:33AM -0600, Jens Axboe wrote:
>> On 9/16/19 3:06 AM, Christoph Hellwig wrote:
>>> On Mon, Sep 16, 2019 at 07:46:29AM +0530, xiubli@redhat.com wrote:
>>>> From: Xiubo Li <xiubli@redhat.com>
>>>>
>>>> To make the patch more readable and cleaner I just split them into 2
>>>> small ones to address the issue from @Ming Lei, thanks very much.
>>> I'd be much happier to just see memalloc_noio_save +
>>> memalloc_noio_restore calls in the right places over sprinkling even
>>> more magic GFP_NOIO arguments.
>> Ugh, I always thought those were kind of lame and band aiding around
>> places where people are too lazy to fix the path to the gfp args.
>> Or maybe areas where it's just feasible.
> The way I understood the discussion around the introduction of these
> flags is that we want to phase out GFP_NOIO and GFP_NOFS in the long
> run, given that ammending all calls is basically impossibly, while
> marking contexts is pretty easy.

This was also my understanding about the memalloc_xx stuff. By going 
through the code and the usage history of it, the best practice of using 
it seems as Bart mentioned for the possibly deep call chains.

Thanks


