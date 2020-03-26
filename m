Return-Path: <SRS0=7tOu=5L=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE28C43331
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 16:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1144F2083E
	for <linux-block@archiver.kernel.org>; Thu, 26 Mar 2020 16:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgCZQg5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:36:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50768 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgCZQg5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Mar 2020 12:36:57 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 630B328DA84
Subject: Re: [PATCH RESEND 1/2] loop: Report EOPNOTSUPP properly
To:     Christoph Hellwig <hch@infradead.org>,
        Evan Green <evgreen@chromium.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, kernel@collabora.com
References: <20200317151111.25749-2-andrzej.p@collabora.com>
 <20200317165106.29282-1-andrzej.p@collabora.com>
 <20200326145253.GA18623@infradead.org>
 <CAE=gft5w_8XwSGRNS6DZ0kppOihoUtYxrMfaTrM5eRifjBYYNQ@mail.gmail.com>
 <20200326155557.GA6043@infradead.org>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <d3c36178-c6d6-154d-436c-e59fa7a47396@collabora.com>
Date:   Thu, 26 Mar 2020 17:36:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200326155557.GA6043@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

W dniu 26.03.2020 o 16:55, Christoph Hellwig pisze:
> On Thu, Mar 26, 2020 at 08:51:21AM -0700, Evan Green wrote:
>> On Thu, Mar 26, 2020 at 7:53 AM Christoph Hellwig <hch@infradead.org> wrote:
>>>
>>> On Tue, Mar 17, 2020 at 05:51:06PM +0100, Andrzej Pietrasiewicz wrote:
>>>> From: Evan Green <evgreen@chromium.org>
>>>>
>>>> Properly plumb out EOPNOTSUPP from loop driver operations, which may
>>>> get returned when for instance a discard operation is attempted but not
>>>> supported by the underlying block device. Before this change, everything
>>>> was reported in the log as an I/O error, which is scary and not
>>>> helpful in debugging.
>>>
>>> This really should be using errno_to_blk_status.
>>
>> I had that here in v7:
>> https://lore.kernel.org/lkml/20191114235008.185111-1-evgreen@chromium.org/
> 
> Well, it wasn't in the version you sent the ping for..
> 

It was me who pinged. I didn't notice the v7, sorry. Is it merged yet?

Andrzej
