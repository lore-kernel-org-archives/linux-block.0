Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126A8C282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 20:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C678520815
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 20:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fjfi.cvut.cz header.i=@fjfi.cvut.cz header.b="Chf1OEjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbfBDU2x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:28:53 -0500
Received: from mailgw1.fjfi.cvut.cz ([147.32.9.3]:41504 "EHLO
        mailgw1.fjfi.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfBDU2x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 15:28:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTP id 743F2A43F5;
        Mon,  4 Feb 2019 21:28:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fjfi.cvut.cz;
        s=20151024; t=1549312130; i=@fjfi.cvut.cz;
        bh=aecN5z9PUwmwE6YRyYCceX0aOk9snZo08W4arT+lYbg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=Chf1OEjsqGXkv2Pdq1knK92KkpeDvtOOeP4aoBtJLAmj11Pyr+9VAZGuS23djrqSh
         GidBVlOtHwvIFxMaUzq/1wFuFty17eGJSb+wIJBiLKXUb5cAY18NFNk0CueYcKDjnn
         YRpYFZ0p7b9XwwP2JKLZ856Ako7QbVZWW1BTw0W0=
X-CTU-FNSPE-Virus-Scanned: amavisd-new at fjfi.cvut.cz
Received: from mailgw1.fjfi.cvut.cz ([127.0.0.1])
        by localhost (mailgw1.fjfi.cvut.cz [127.0.0.1]) (amavisd-new, port 10022)
        with ESMTP id e6yxigrl0tO5; Mon,  4 Feb 2019 21:28:46 +0100 (CET)
Received: from linux.fjfi.cvut.cz (linux.fjfi.cvut.cz [147.32.5.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgw1.fjfi.cvut.cz (Postfix) with ESMTPS id 0851FA43BF;
        Mon,  4 Feb 2019 21:28:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailgw1.fjfi.cvut.cz 0851FA43BF
Received: by linux.fjfi.cvut.cz (Postfix, from userid 1001)
        id AE1206004E; Mon,  4 Feb 2019 21:28:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by linux.fjfi.cvut.cz (Postfix) with ESMTP id 79EEF6004D;
        Mon,  4 Feb 2019 21:28:12 +0100 (CET)
Date:   Mon, 4 Feb 2019 21:28:12 +0100 (CET)
From:   David Kozub <zub@linux.fjfi.cvut.cz>
To:     Christoph Hellwig <hch@infradead.org>
cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 01/16] block: sed-opal: fix typos and formatting
In-Reply-To: <20190204144243.GA31132@infradead.org>
Message-ID: <alpine.LRH.2.21.1902042110370.10661@linux.fjfi.cvut.cz>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz> <1549054223-12220-2-git-send-email-zub@linux.fjfi.cvut.cz> <20190204144243.GA31132@infradead.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 4 Feb 2019, Christoph Hellwig wrote:

> On Fri, Feb 01, 2019 at 09:50:08PM +0100, David Kozub wrote:
>> This should make no change in functionality.
>> The formatting changes were triggered by checkpatch.pl.
>>
>> Signed-off-by: David Kozub <zub@linux.fjfi.cvut.cz>
>> Reviewed-by: Scott Bauer <sbauer@plzdonthack.me>
>> ---
>>  block/sed-opal.c | 19 +++++++++++--------
>>  1 file changed, 11 insertions(+), 8 deletions(-)
>>
>> diff --git a/block/sed-opal.c b/block/sed-opal.c
>> index e0de4dd448b3..c882a193e162 100644
>> --- a/block/sed-opal.c
>> +++ b/block/sed-opal.c
>> @@ -11,8 +11,8 @@
>>   *
>>   * This program is distributed in the hope it will be useful, but WITHOUT
>>   * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> - * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
>> - * more details.
>> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
>> + * for more details.
>
> What exactly is the fix here?
>
> If we want to fix the licence boilerplate we should switch it to an
> SPDX tag instead.
>
> Otherwise this looks fine to me.

I thought checkpatch.pl -f block/sed-opal.c complained about the line 
being too long. But when I try that again now (with the original version), 
it does not complain. So I probably saw a ghost.

I'll undo this change.
