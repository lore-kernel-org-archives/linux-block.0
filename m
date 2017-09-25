Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:51043 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933521AbdIYKPY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Sep 2017 06:15:24 -0400
Received: by mail-wm0-f49.google.com with SMTP id b195so17877774wmb.5
        for <linux-block@vger.kernel.org>; Mon, 25 Sep 2017 03:15:24 -0700 (PDT)
Subject: Re: [PATCH 5/6] lightnvm: pblk: print incompatible line version
 correctly
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
        Rakesh Pandit <rakesh@tuxera.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170921112801.GA28567@dhcp-216.srv.tuxera.com>
 <3814BFB5-5966-4737-8B98-7A2762E409FD@lightnvm.io>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <7dcd786f-f5da-a70f-9a78-a5ccc5fe321b@lightnvm.io>
Date: Mon, 25 Sep 2017 12:15:22 +0200
MIME-Version: 1.0
In-Reply-To: <3814BFB5-5966-4737-8B98-7A2762E409FD@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/22/2017 11:01 AM, Javier González wrote:
>> On 21 Sep 2017, at 13.28, Rakesh Pandit <rakesh@tuxera.com> wrote:
>>
>> Correct it by coverting little endian to cpu endian and also define a
>> macro for line version so that maintenance is easy.
>>
>> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
>> ---
>> drivers/lightnvm/pblk-core.c     | 2 +-
>> drivers/lightnvm/pblk-recovery.c | 4 ++--
>> drivers/lightnvm/pblk.h          | 1 +
>> 3 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>> index 74ddb30..57583a1 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -991,7 +991,7 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
>> 	memcpy(smeta_buf->header.uuid, pblk->instance_uuid, 16);
>> 	smeta_buf->header.id = cpu_to_le32(line->id);
>> 	smeta_buf->header.type = cpu_to_le16(line->type);
>> -	smeta_buf->header.version = cpu_to_le16(1);
>> +	smeta_buf->header.version = SMETA_VERSION;
>>
>> 	/* Start metadata */
>> 	smeta_buf->seq_nr = cpu_to_le64(line->seq_nr);
>> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
>> index 1869eef..686bc17 100644
>> --- a/drivers/lightnvm/pblk-recovery.c
>> +++ b/drivers/lightnvm/pblk-recovery.c
>> @@ -876,9 +876,9 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>> 		if (le32_to_cpu(smeta_buf->header.identifier) != PBLK_MAGIC)
>> 			continue;
>>
>> -		if (le16_to_cpu(smeta_buf->header.version) != 1) {
>> +		if (smeta_buf->header.version != SMETA_VERSION) {
>> 			pr_err("pblk: found incompatible line version %u\n",
>> -					smeta_buf->header.version);
>> +					le16_to_cpu(smeta_buf->header.version));
>> 			return ERR_PTR(-EINVAL);
>> 		}
>>
>> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
>> index eaf5397..87b1d7f 100644
>> --- a/drivers/lightnvm/pblk.h
>> +++ b/drivers/lightnvm/pblk.h
>> @@ -318,6 +318,7 @@ enum {
>> };
>>
>> #define PBLK_MAGIC 0x70626c6b /*pblk*/
>> +#define SMETA_VERSION cpu_to_le16(1)
>>
>> struct line_header {
>> 	__le32 crc;
>> --
>> 2.5.0
> 
> It's a different way of doing it, and it's fine to have a macro.
> 
> Reviewed-by: Javier González <javier@cnexlabs.com>
> 

Thanks, I picked it up.
