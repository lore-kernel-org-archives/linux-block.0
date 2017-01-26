Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:38412 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753167AbdAZPBD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2017 10:01:03 -0500
Received: by mail-it0-f48.google.com with SMTP id c7so34942241itd.1
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2017 07:01:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54ba79f7-93f1-6a93-79eb-7a7ba0f0d623@linux.intel.com>
References: <20170124101757.19676-1-linus.walleij@linaro.org>
 <20170124101757.19676-2-linus.walleij@linaro.org> <54ba79f7-93f1-6a93-79eb-7a7ba0f0d623@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 26 Jan 2017 16:01:01 +0100
Message-ID: <CACRpkdaatoF804RmOAo+TPag2kkUeb3OsAyqWH5UCXHaGZgMVg@mail.gmail.com>
Subject: Re: [PATCH 1/6] mmc: block: break out mmc_blk_rw_cmd_abort()
To: Mateusz Nowak <mateusz.nowak@linux.intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jan 25, 2017 at 10:23 AM, Mateusz Nowak
<mateusz.nowak@linux.intel.com> wrote:
> On 1/24/2017 11:17, Linus Walleij wrote:
>>
>> As a first step toward breaking apart the very complex function
>> mmc_blk_issue_rw_rq() we break out the command abort code.
>> This code assumes "ret" is != 0 and then repeatedly hammers
>> blk_end_request() until the request to the block layer to end
>> the request succeeds.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>>  drivers/mmc/core/block.c | 17 ++++++++++++-----
>>  1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index 7bd03381810d..14efe92a14ef 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -1598,6 +1598,17 @@ static int mmc_blk_cmd_err(struct mmc_blk_data *md,
>> struct mmc_card *card,
>>         return ret;
>>  }
>>
>> +static void mmc_blk_rw_cmd_abort(struct mmc_card *card, struct request
>> *req)
>> +{
>> +       int ret = 1;
>
> blk_end_request is returning bool, so maybe this variable should have
> matching type since it is only usage in this scope? And maybe it should have
> more meaningful name for this case?

I am just moving/refactoring the code syntax without changing any
semantics. It was an int in the old code so it is an int in the new
code.

It is possible to fix this and other problems as separate patches.

As you can see it also spins here for all eternity if the function
just returns != 0 all the time, that doesn't look good either.

Yours,
Linus Walleij
