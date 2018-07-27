Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:38110 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388467AbeG0U4C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jul 2018 16:56:02 -0400
MIME-Version: 1.0
References: <20180726142239.44669-1-colyli@suse.de> <20180726142239.44669-9-colyli@suse.de>
 <CADfjVrhRtwdGF6bs_yCQms=TXxHynZb87r9gzRNoicQ70-n8OQ@mail.gmail.com>
In-Reply-To: <CADfjVrhRtwdGF6bs_yCQms=TXxHynZb87r9gzRNoicQ70-n8OQ@mail.gmail.com>
From: Noah Massey <noah.massey@gmail.com>
Date: Fri, 27 Jul 2018 15:32:06 -0400
Message-ID: <CADfjVrj+3pqT3xrQW4tEcTJo0OCFXpovLj9+EixBChptdtLRzw@mail.gmail.com>
Subject: Re: [PATCH 8/9] bcache: initiate bcache_debug to NULL
To: Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 27, 2018 at 1:37 PM Noah Massey <noah.massey@gmail.com> wrote:
> On Thu, Jul 26, 2018, 10:23 AM Coly Li <colyli@suse.de> wrote:
>>
>> Global variable bcache_debug is firstly initialized in bch_debug_init(),
>> and destroyed in bch_debug_exit(). bch_debug_init() is called in
>> bcache_init() with many other functions, if one of the previous calling
>> onces failed, bcache_exit() will be called in the failure path.
>>
>> The problem is, if bcache_init() fails before bch_debug_init() is called,
>> then in bcache_exit() when bch_debug_exit() is called to destroy global
>> variable bcache_debug, at this moment bcache_debug is unndefined, then the
>> test of "if (!IS_ERR_OR_NULL(bcache_debug))" might be buggy.
>>
>> This patch initializes global varabile bcache_debug to be NULL, to make
>> the failure code path to be predictable.
>>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> ---
>
>
> Makes sense
>
> Reviewed-by: Noah Massey <noah.massey@gmail.com>
>

Wait... aren't static variables already initialized to 0?
So this makes it explicit, but no code change to generated binary, right?

>>  drivers/md/bcache/debug.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
>> index 57f8f5aeee55..24b0eb65ddec 100644
>> --- a/drivers/md/bcache/debug.c
>> +++ b/drivers/md/bcache/debug.c
>> @@ -17,7 +17,7 @@
>>  #include <linux/random.h>
>>  #include <linux/seq_file.h>
>>
>> -struct dentry *bcache_debug;
>> +struct dentry *bcache_debug = NULL;
>>
>>  #ifdef CONFIG_BCACHE_DEBUG
>>
>> --
>> 2.17.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bcache" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
