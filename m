Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99728CA9EC7
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 22:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649752067D
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 22:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfJ3WQS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:16:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39676 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfJ3WQS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 18:16:18 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 4672C28FB46
Subject: Re: [PATCH blktests 0/3] Add --config argument for custom config
 filenames
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com, kernel@collabora.com,
        krisman@collabora.com
References: <20191029200942.83044-1-andrealmeid@collabora.com>
 <20191030211825.GC326591@vader>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <f425c7ca-3993-44d3-71b4-a711d3918f94@collabora.com>
Date:   Wed, 30 Oct 2019 19:14:50 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191030211825.GC326591@vader>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/30/19 6:18 PM, Omar Sandoval wrote:
> On Tue, Oct 29, 2019 at 05:09:39PM -0300, André Almeida wrote:
>> Instead of just using the default config file, one may also find useful to
>> specify which configuration file would like to use without editing the config
>> file, like this:
>>
>> $ ./check --config=tests_nvme
>> ...
>> $ ./check -c tests_scsi
>>
>> This pull request solves this. This change means to be optional, in the sense
>> that the default behavior should not be modified and current setups will not be
>> affect by this. To check if this is true, I have done the following test:
>>
>> - Print the value of variables $DEVICE_ONLY, $QUICK_RUN, $TIMEOUT,
>>   $RUN_ZONED_TESTS, $OUTPUT, $EXCLUDE
>>   
>> - Run with the following setups:
>>     - with a config file in the dir
>>     - without a config file in the dir
>>     - configuring using command line arguments
>>
>> With both original code and with my changes, I validated that the values
>> remained the same. Then, I used the argument --config=test_config to check that
>> the values of variables are indeed changing.
>>
>> This patchset add this feature, update the docs and fix a minor issue with a
>> command line argument. Also, I have changed "# shellcheck disable=SC1091" to
>> "# shellcheck source=/dev/null", since it seems the proper way to disable this
>> check according to shellcheck documentation[1].
>>
>> Thanks,
>> André
>>
>> [1] https://github.com/koalaman/shellcheck/wiki/SC1090#exceptions
>>
>> This patch is also avaible at GitHub:
>> https://github.com/osandov/blktests/pull/56
>>
>> André Almeida (3):
>>   check: Add configuration file option
>>   Documentation: Add information about `--config` argument
>>   check: Make "device-only" option a valid option
> 
> Patches 2 and 3 look good (although a nitpick is that patch 3 could be
> first since it's a bug fix that I could take independently of the other
> patches). I had one comment on patch 1.
> 

Nice catch, the order will be fixed at v2 :)

> Thanks!
> 

