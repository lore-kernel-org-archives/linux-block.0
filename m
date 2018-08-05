Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] lightnvm: remove minor version check for 2.0
To: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Cc: Javier Gonzalez <javier@cnexlabs.com>,
 "Konopko, Igor J" <igor.j.konopko@intel.com>,
 "marcin.dziegielewski@intel.com" <marcin.dziegielewski@intel.com>,
 Hans Holmberg <hans.holmberg@cnexlabs.com>, Heiner Litz <hlitz@ucsc.edu>,
 Young Tack Tack Jin <youngtack.jin@circuitblvd.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180803090237.2022-1-mb@lightnvm.io>
 <7B08AEC1-90F8-4AE0-AE46-BADF8CC8D270@cnexlabs.com>
 <2f1d5972-3257-22e0-efd7-0038f979f438@lightnvm.io>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e2436194-0de5-df6a-5912-3346d6fca75b@kernel.dk>
Date: Sun, 5 Aug 2018 08:26:14 -0600
MIME-Version: 1.0
In-Reply-To: <2f1d5972-3257-22e0-efd7-0038f979f438@lightnvm.io>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/5/18 2:29 AM, Matias Bjørling wrote:
> On 8/3/18 2:07 PM, Javier Gonzalez wrote:
>>> On 3 Aug 2018, at 11.02, Matias Bjørling <mb@lightnvm.io> wrote:
>>>
>>> A minor version number increase should not break backwards
>>> compatibility.
>>>
>>> Fixes: 3cb98f84d368b ("lightnvm: add minor version to generic geometry")
>>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>>> ---
>>> drivers/nvme/host/lightnvm.c | 6 ------
>>> 1 file changed, 6 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>>> index d9e4cccd5b66..a156fe3ca7d3 100644
>>> --- a/drivers/nvme/host/lightnvm.c
>>> +++ b/drivers/nvme/host/lightnvm.c
>>> @@ -414,12 +414,6 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
>>> 	/* Set compacted version for upper layers */
>>> 	geo->version = NVM_OCSSD_SPEC_20;
>>>
>>> -	if (!(geo->major_ver_id == 2 && geo->minor_ver_id == 0)) {
>>> -		pr_err("nvm: OCSSD version not supported (v%d.%d)\n",
>>> -				geo->major_ver_id, geo->minor_ver_id);
>>> -		return -EINVAL;
>>> -	}
>>> -
>>> 	geo->num_ch = le16_to_cpu(id->num_grp);
>>> 	geo->num_lun = le16_to_cpu(id->num_pu);
>>> 	geo->all_luns = geo->num_ch * geo->num_lun;
>>> --
>>> 2.11.0
>>
>> Looks good to me.
>>
>> Reviewed-by: Javier González <javier@cnexlabs.com>
>>
> 
> Hi Jens,
> 
> Would it be possible to pick this one up for 4.19?

Done.

-- 
Jens Axboe
