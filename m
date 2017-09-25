Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:47624 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932716AbdIYKPE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Sep 2017 06:15:04 -0400
Received: by mail-wm0-f49.google.com with SMTP id r136so17886521wmf.2
        for <linux-block@vger.kernel.org>; Mon, 25 Sep 2017 03:15:04 -0700 (PDT)
Subject: Re: [PATCH 3/6] lightnvm: pblk: fix message if L2P MAP is in device
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
        Rakesh Pandit <rakesh@tuxera.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170921112655.GA28539@dhcp-216.srv.tuxera.com>
 <D3D2476A-E07C-4012-A731-27552AFFCD5D@lightnvm.io>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <89391d08-1439-76bc-3c9b-fbfd9b31131c@lightnvm.io>
Date: Mon, 25 Sep 2017 12:15:02 +0200
MIME-Version: 1.0
In-Reply-To: <D3D2476A-E07C-4012-A731-27552AFFCD5D@lightnvm.io>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/22/2017 10:52 AM, Javier Gonz�lez wrote:
>> On 21 Sep 2017, at 13.26, Rakesh Pandit <rakesh@tuxera.com> wrote:
>>
>> This usually happens if we are developing with qemu and ll2pmode has
>> default value.  Even in that case message seems wrong.
>>
>> Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
>> ---
>> drivers/lightnvm/pblk-init.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>> index 470ef04..c5c1337 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -913,7 +913,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>> 	int ret;
>>
>> 	if (dev->identity.dom & NVM_RSP_L2P) {
>> -		pr_err("pblk: device-side L2P table not supported. (%x)\n",
>> +		pr_err("pblk: device-side L2P table supported. (%x)\n",
>> 							dev->identity.dom);
>> 		return ERR_PTR(-EINVAL);
>> 	}
>> --
>> 2.5.0
> 
> You're right. This is inherited from rrpc.
> 
> Can we instead write "pblk: full host-side L2P table not supported"?
> People will not know about the hybrid device/host L2P as time goes by
> and it will just be confusing. I'm not even sure this will be part of
> the 2.0 spec, so it will probably go away with time...
> 
> Javier
> 
Thanks, I picked it up.
