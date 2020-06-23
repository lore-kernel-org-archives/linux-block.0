Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B2AC433DF
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 23:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C692B2078E
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 23:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387640AbgFWXUw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:20:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42479 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387596AbgFWXUv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 19:20:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id b5so150431pfp.9
        for <linux-block@vger.kernel.org>; Tue, 23 Jun 2020 16:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OqXkQ4Twvc1EPv01H29N9//f6s8wcZ8KXM2PMqYzUEA=;
        b=kmVZe0ebgG2Ox0hbc9ATIu1Y7SURvJ1Hgs93I4er6/8dDi5YU+6Z8B5sDGjsPzNKOY
         YlFSq1mGLQXACWwVZzgICbXZBPGZEyj6/ljLF37KMm/dTCdrqAoYQw/q4i1w9ntuSpUG
         i1epr34pSot97Z7zWOhFzf40c3Di0XF/Gpl7Ld4WzYbG+heSrCQzC3OtdgIFFEerksYA
         SWpaVVYHbDgpZZyR23O0SmrBBGhnGF0+Em/4+WCxGjE3wAaDrHqlGmeonByFRn9dLQeT
         kDhpK50FC5ZnAnUD68JfzJO6vHolIxofiBVyTdQwof89nD8JzAirFZC39urAU9Sea75V
         Yb2w==
X-Gm-Message-State: AOAM531g6rfUaw80S6Usj6NzKxU8jJrXx4Ujx6c29IgkyeMIWdEtywY3
        AmqWAg09y26qKYo28r8/CYc=
X-Google-Smtp-Source: ABdhPJwINS/umzo+fDugYGIdrS0In/qd/5CJL8VHmSddGJVYi9huohVi75DPxdOsPGbkCNjU6dnTlg==
X-Received: by 2002:a63:ef4e:: with SMTP id c14mr11936936pgk.259.1592954448897;
        Tue, 23 Jun 2020 16:20:48 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:acd7:a900:b9f:8b8b? ([2601:647:4802:9070:acd7:a900:b9f:8b8b])
        by smtp.gmail.com with ESMTPSA id x8sm3843548pff.54.2020.06.23.16.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 16:20:48 -0700 (PDT)
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set
 support
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-4-kbusch@kernel.org>
 <69e8e88c-097b-368d-58f4-85d11110386d@grimberg.me>
 <20200623112551.GB117742@localhost.localdomain>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9c710c06-5be7-5aff-d919-883e19dfaa44@grimberg.me>
Date:   Tue, 23 Jun 2020 16:20:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200623112551.GB117742@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 6/23/20 4:25 AM, Niklas Cassel wrote:
> On Tue, Jun 23, 2020 at 01:53:47AM -0700, Sagi Grimberg wrote:
>>
>>
>> On 6/22/20 9:25 AM, Keith Busch wrote:
>>> From: Niklas Cassel <niklas.cassel@wdc.com>
>>>
>>> Implements support for the I/O Command Sets command set. The command set
>>> introduces a method to enumerate multiple command sets per namespace. If
>>> the command set is exposed, this method for enumeration will be used
>>> instead of the traditional method that uses the CC.CSS register command
>>> set register for command set identification.
>>>
>>> For namespaces where the Command Set Identifier is not supported or
>>> recognized, the specific namespace will not be created.
>>>
>>> Reviewed-by: Javier González <javier.gonz@samsung.com>
>>> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
>>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> Reviewed-by: Matias Bjørling <matias.bjorling@wdc.com>
>>> Reviewed-by: Daniel Wagner <dwagner@suse.de>
>>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
>>> ---
>>>    drivers/nvme/host/core.c | 48 +++++++++++++++++++++++++++++++++-------
>>>    drivers/nvme/host/nvme.h |  1 +
>>>    include/linux/nvme.h     | 19 ++++++++++++++--
>>>    3 files changed, 58 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 9491dbcfe81a..45a3cb5a35bd 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -1056,8 +1056,13 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
>>>    	return error;
>>>    }
>>> +static bool nvme_multi_css(struct nvme_ctrl *ctrl)
>>> +{
>>> +	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
>>> +}
>>> +
>>>    static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
>>> -		struct nvme_ns_id_desc *cur)
>>> +		struct nvme_ns_id_desc *cur, bool *csi_seen)
>>>    {
>>>    	const char *warn_str = "ctrl returned bogus length:";
>>>    	void *data = cur;
>>> @@ -1087,6 +1092,15 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
>>>    		}
>>>    		uuid_copy(&ids->uuid, data + sizeof(*cur));
>>>    		return NVME_NIDT_UUID_LEN;
>>> +	case NVME_NIDT_CSI:
>>> +		if (cur->nidl != NVME_NIDT_CSI_LEN) {
>>> +			dev_warn(ctrl->device, "%s %d for NVME_NIDT_CSI\n",
>>> +				 warn_str, cur->nidl);
>>> +			return -1;
>>> +		}
>>> +		memcpy(&ids->csi, data + sizeof(*cur), NVME_NIDT_CSI_LEN);
>>> +		*csi_seen = true;
>>> +		return NVME_NIDT_CSI_LEN;
>>>    	default:
>>>    		/* Skip unknown types */
>>>    		return cur->nidl;
>>> @@ -1097,10 +1111,9 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
>>>    		struct nvme_ns_ids *ids)
>>>    {
>>>    	struct nvme_command c = { };
>>> -	int status;
>>> +	bool csi_seen = false;
>>> +	int status, pos, len;
>>>    	void *data;
>>> -	int pos;
>>> -	int len;
>>>    	c.identify.opcode = nvme_admin_identify;
>>>    	c.identify.nsid = cpu_to_le32(nsid);
>>> @@ -1130,13 +1143,19 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
>>>    		if (cur->nidl == 0)
>>>    			break;
>>> -		len = nvme_process_ns_desc(ctrl, ids, cur);
>>> +		len = nvme_process_ns_desc(ctrl, ids, cur, &csi_seen);
>>>    		if (len < 0)
>>>    			goto free_data;
>>>    		len += sizeof(*cur);
>>>    	}
>>>    free_data:
>>> +	if (!status && nvme_multi_css(ctrl) && !csi_seen) {
>>
>> We will clear the status if we detect a path error, that is to
>> avoid needlessly removing the ns for path failures, so you should
>> check at the goto site.
> 
> The problem is that this check has to be done after checking all the ns descs,
> so this check to be done as the final thing, at least after processing all the
> ns descs. No matter if nvme_process_ns_desc() returned an error, or if
> simply NVME_NIDT_CSI wasn't part of the ns desc list, so the loop reached the
> end without error.
> 
> Even if the nvme command failed and the status was cleared:
> 
>                  if (status > 0 && !(status & NVME_SC_DNR))
>                          status = 0;
> 
> we still need to return an error, if (nvme_multi_css(ctrl) && !csi_seen).
> (Not reporting a CSI when nvme_multi_css() is enabled, is fatal.)
> 
> That is why the code looks like it does.
> 
> I guess we could do something like this, which does the same thing,
> but perhaps is a bit clearer:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e95f0c498a6b..bef687b9a277 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1160,8 +1160,10 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
>                    * Don't treat an error as fatal, as we potentially already
>                    * have a NGUID or EUI-64.
>                    */
> -               if (status > 0 && !(status & NVME_SC_DNR))
> +               if (status > 0 && !(status & NVME_SC_DNR)) {
>                          status = 0;
> +                       goto csi_check;
> +               }

I think its the opposite. If we failed with DNR, you should assume
that either the controller wants the host to retry, or its a
path/transport error. So we need to leave this namespace alone and
assume that when the host is connected back to the controller, the
scan_work will revalidate again.

So you should fail the csi_check only if you see a DNR error status.
