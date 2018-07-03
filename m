Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43037 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752762AbeGCTOx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jul 2018 15:14:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id r13-v6so2409120ljg.10
        for <linux-block@vger.kernel.org>; Tue, 03 Jul 2018 12:14:53 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: limit get chunk meta request size
To: javier@cnexlabs.com
Cc: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180702080223.13214-1-mb@lightnvm.io>
 <C0B26672-CFD1-4058-A979-48341CD40F8D@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <dd3b8963-1f11-59a6-dc60-e0171687a727@lightnvm.io>
Date: Tue, 3 Jul 2018 21:14:50 +0200
MIME-Version: 1.0
In-Reply-To: <C0B26672-CFD1-4058-A979-48341CD40F8D@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 07/03/2018 09:10 PM, Javier Gonzalez wrote:
>> On 2 Jul 2018, at 10.02, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> For devices that does not specify a limit on its transfer size, the
>> get_chk_meta command may send down a single I/O retrieving the full
>> chunk metadata table. Resulting in large 2-4MB I/O requests. Instead,
>> split up the I/Os to a maximum of 256KB and issue them separately to
>> reduce memory requirements.
>>
>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>> ---
>> drivers/nvme/host/lightnvm.c | 10 ++++++++--
>> 1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>> index b9989717418d..3b644b0e9713 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -583,7 +583,13 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
>> 	struct ppa_addr ppa;
>> 	size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
>> 	size_t log_pos, offset, len;
>> -	int ret, i;
>> +	int ret, i, max_len;
>> +
>> +	/*
>> +	 * limit requests to maximum 256K to avoid issuing arbitrary large
>> +	 * requests when the device does not specific a maximum transfer size.
>> +	 */
>> +	max_len = min_t(unsigned int, ctrl->max_hw_sectors << 9, 256 * 1024);
>>
>> 	/* Normalize lba address space to obtain log offset */
>> 	ppa.ppa = slba;
>> @@ -596,7 +602,7 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
>> 	offset = log_pos * sizeof(struct nvme_nvm_chk_meta);
>>
>> 	while (left) {
>> -		len = min_t(unsigned int, left, ctrl->max_hw_sectors << 9);
>> +		len = min_t(unsigned int, left, max_len);
>>
>> 		ret = nvme_get_log_ext(ctrl, ns, NVME_NVM_LOG_REPORT_CHUNK,
>> 				dev_meta, len, offset);
>> --
>> 2.11.0
> 
> Is this a v2? I remember seeing this patch being posted before [1]. It
> still looks good to me :)
> 
> 
> [1] https://lkml.org/lkml/2018/6/12/466
> 
> 
> Reviewed-by: Javier González <javier@cnexlabs.com>
> 

I changed the title. Since it didn't touch pblk. Thanks.
