Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B13C7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 10:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D772064B
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 10:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbfGOKtd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:49:33 -0400
Received: from mail02.iobjects.de ([188.40.134.68]:56232 "EHLO
        mail02.iobjects.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbfGOKtc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 06:49:32 -0400
Received: from tux.wizards.de (pD9EBFA35.dip0.t-ipconnect.de [217.235.250.53])
        by mail02.iobjects.de (Postfix) with ESMTPSA id 13CB14166996;
        Mon, 15 Jul 2019 12:49:31 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.wizards.de (Postfix) with ESMTP id C280EF01582;
        Mon, 15 Jul 2019 12:49:30 +0200 (CEST)
Subject: Re: [PATCH BUGFIX IMPROVEMENT 1/1] block, bfq: check also in-flight
 I/O in dispatch plugging
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name
References: <20190715093153.19821-1-paolo.valente@linaro.org>
 <20190715093153.19821-2-paolo.valente@linaro.org>
 <88e3c1e1-224f-a9a8-0875-848ba23b6fbf@applied-asynchrony.com>
 <B0406DB0-1003-4610-8A75-F3D7614C616E@linaro.org>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <2c15c4bc-145d-fb0d-ae5a-2a8ce36f977b@applied-asynchrony.com>
Date:   Mon, 15 Jul 2019 12:49:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <B0406DB0-1003-4610-8A75-F3D7614C616E@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/15/19 12:18 PM, Paolo Valente wrote:
> Didn't I simply move it forward in that commit?
> 
>> Il giorno 15 lug 2019, alle ore 12:16, Holger Hoffstätte <holger@applied-asynchrony.com> ha scritto:
>> Paolo,
>>
>> The function idling_needed_for_service_guarantees() was just removed in 5.3-commit
>> 3726112ec731 ("block, bfq: re-schedule empty queues if they deserve I/O plugging").

Argh, sorry - yes you did, it failed to apply because the asymmetric_scenario
variable was already gone. Fixing the patch to just return the expression so that
it matches 3726112ec731 worked.

All good!
Holger
