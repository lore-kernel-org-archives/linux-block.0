Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37070 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbeBVJli (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Feb 2018 04:41:38 -0500
Received: by mail-lf0-f66.google.com with SMTP id y19so6491222lfd.4
        for <linux-block@vger.kernel.org>; Thu, 22 Feb 2018 01:41:37 -0800 (PST)
Subject: Re: [PATCH 09/20] lightnvm: use generic identify structure
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-10-git-send-email-javier@cnexlabs.com>
 <6f76c204-847a-2f20-3070-06cb28a66555@lightnvm.io>
 <1FE350B9-E8CD-43BC-8AE8-2593A6398D3F@lightnvm.io>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <25780a53-504e-70c6-3ff4-d20c43e8e3b2@lightnvm.io>
Date: Thu, 22 Feb 2018 10:41:35 +0100
MIME-Version: 1.0
In-Reply-To: <1FE350B9-E8CD-43BC-8AE8-2593A6398D3F@lightnvm.io>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/22/2018 08:49 AM, Javier González wrote:
>> On 22 Feb 2018, at 08.47, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 02/21/2018 10:26 AM, Javier González wrote:
>>> Create a generic identify structure to collect the identify information
>>> before knowing the spec. version. This forces different version paths to
>>> cast the structure to their spec structure, thus making the code less
>>> error prone and more maintainable.
>>> Signed-off-by: Javier González <javier@cnexlabs.com>
>>> ---
>>>   drivers/nvme/host/lightnvm.c | 32 ++++++++++++++++++++------------
>>>   1 file changed, 20 insertions(+), 12 deletions(-)
>>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>>> index 9c1f8225c4e1..70dc4740f0d3 100644
>>> --- a/drivers/nvme/host/lightnvm.c
>>> +++ b/drivers/nvme/host/lightnvm.c
>>> @@ -170,6 +170,12 @@ struct nvme_nvm_id12 {
>>>   	__u8			resv2[2880];
>>>   } __packed;
>>>   +/* Generic identification structure */
>>> +struct nvme_nvm_id {
>>> +	__u8			ver_id;
>>> +	__u8			resv[4095];
>>> +} __packed;
>>> +
>>>   struct nvme_nvm_bb_tbl {
>>>   	__u8	tblid[4];
>>>   	__le16	verid;
>>> @@ -279,9 +285,10 @@ static void nvme_nvm_set_addr_12(struct nvm_addr_format_12 *dst,
>>>   	dst->sec_mask = ((1ULL << dst->sec_len) - 1) << dst->sec_offset;
>>>   }
>>>   -static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
>>> +static int nvme_nvm_setup_12(struct nvme_nvm_id *gen_id,
>>>   			     struct nvm_dev_geo *dev_geo)
>>>   {
>>> +	struct nvme_nvm_id12 *id = (struct nvme_nvm_id12 *)gen_id;
>>>   	struct nvme_nvm_id12_grp *src;
>>>   	int sec_per_pg, sec_per_pl, pg_per_blk;
>>>   @@ -380,9 +387,11 @@ static void nvme_nvm_set_addr_20(struct nvm_addr_format *dst,
>>>   	dst->sec_mask = ((1ULL << dst->sec_len) - 1) << dst->sec_offset;
>>>   }
>>>   -static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
>>> +static int nvme_nvm_setup_20(struct nvme_nvm_id *gen_id,
>>>   			     struct nvm_dev_geo *dev_geo)
>>>   {
>>> +	struct nvme_nvm_id20 *id = (struct nvme_nvm_id20 *)gen_id;
>>> +
>>>   	dev_geo->major_ver_id = id->mjr;
>>>   	dev_geo->minor_ver_id = id->mnr;
>>>   @@ -427,19 +436,19 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
>>>   static int nvme_nvm_identity(struct nvm_dev *nvmdev)
>>>   {
>>>   	struct nvme_ns *ns = nvmdev->q->queuedata;
>>> -	struct nvme_nvm_id12 *id;
>>> +	struct nvme_nvm_id *nvme_nvm_id;
>>>   	struct nvme_nvm_command c = {};
>>>   	int ret;
>>>     	c.identity.opcode = nvme_nvm_admin_identity;
>>>   	c.identity.nsid = cpu_to_le32(ns->head->ns_id);
>>>   -	id = kmalloc(sizeof(struct nvme_nvm_id12), GFP_KERNEL);
>>> -	if (!id)
>>> +	nvme_nvm_id = kmalloc(sizeof(struct nvme_nvm_id), GFP_KERNEL);
>>> +	if (!nvme_nvm_id)
>>>   		return -ENOMEM;
>>>     	ret = nvme_submit_sync_cmd(ns->ctrl->admin_q, (struct nvme_command *)&c,
>>> -				id, sizeof(struct nvme_nvm_id12));
>>> +				nvme_nvm_id, sizeof(struct nvme_nvm_id));
>>>   	if (ret) {
>>>   		ret = -EIO;
>>>   		goto out;
>>> @@ -449,22 +458,21 @@ static int nvme_nvm_identity(struct nvm_dev *nvmdev)
>>>   	 * The 1.2 and 2.0 specifications share the first byte in their geometry
>>>   	 * command to make it possible to know what version a device implements.
>>>   	 */
>>> -	switch (id->ver_id) {
>>> +	switch (nvme_nvm_id->ver_id) {
>>>   	case 1:
>>> -		ret = nvme_nvm_setup_12(id, &nvmdev->dev_geo);
>>> +		ret = nvme_nvm_setup_12(nvme_nvm_id, &nvmdev->dev_geo);
>>>   		break;
>>>   	case 2:
>>> -		ret = nvme_nvm_setup_20((struct nvme_nvm_id20 *)id,
>>> -							&nvmdev->dev_geo);
>>> +		ret = nvme_nvm_setup_20(nvme_nvm_id, &nvmdev->dev_geo);
>>>   		break;
>>>   	default:
>>>   		dev_err(ns->ctrl->device, "OCSSD revision not supported (%d)\n",
>>> -							id->ver_id);
>>> +							nvme_nvm_id->ver_id);
>>>   		ret = -EINVAL;
>>>   	}
>>>     out:
>>> -	kfree(id);
>>> +	kfree(nvme_nvm_id);
>>>   	return ret;
>>>   }
>>>
>>
>> Thanks for another way to represent it. I want to keep the original
>> path. If we are going that down road, then one should maybe look into
>> unifying the "three" data structures, and have the version as the base
>> property and the others in each their sub data structure.
> 
> That's what this structure aims to do, since the version is shared. But
> you call if you want to cast unrelated structures back an forth. I'll
> revert it...
> 
> Javier
> 

In that case, the patch could look like

struct nvm_id {
	__u8 ver_id;

	union {
		struct v1 {};
		struct v2 {};
	};
};

I'm good with just having the single cast instead of putting each under 
a v1/v2 variable or using nvm_id first, and then goto either v1 or v2.
