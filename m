Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3150BC433DF
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 17:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB1820738
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 17:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405587AbgFXRqI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:46:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40420 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405556AbgFXRqI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 13:46:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id u5so1468049pfn.7
        for <linux-block@vger.kernel.org>; Wed, 24 Jun 2020 10:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6ZuPfoIsOlhMNdcAnzkgxdvTGnwTXlBb8uOi41AOKTw=;
        b=LJMnwO1Hl7utorARlYlCyjuhmrNmEofFaQJriz67EEMomIxhqz+dC7NRZNc9DVv9Rs
         G92UdXPDxU/DUgtbWJ2p1RHmylOf0PjROd1SFZyINCpbal3rv6gfA+4eJMRX9okIfoYX
         wDatZrFggaSz6WZUvLt/sfFuCAanMF/NXCoXKPh73iqqLW2cfYpmbnwh9vsUNIg7ccvD
         eUrPXHdt7MrN83sQyt3liIRxdycLieMR9huNlzhSucCP89s+rGwDot8VUGmj8cdGpWJa
         EvGb09VNSEXR3YwuIC3xLXjz9m6L6bc5a0pXtSFgvtgIp7hUzX2QKs622+eGbcA/K8hK
         eL0Q==
X-Gm-Message-State: AOAM533regio5qsnnZSW8hREVpcmPsOS9ZN2LtFDijNef9kzoEmSx2s1
        CJD2a9RrB8YsaSTU3MEjrRw=
X-Google-Smtp-Source: ABdhPJyCpH43JPzB8LeKOtaZuuTnplK2rIVDji8XDVbr6qO/Rz027O/8l0VcqoMtWpgzjHppDj1oUw==
X-Received: by 2002:a63:d208:: with SMTP id a8mr22435313pgg.351.1593020767184;
        Wed, 24 Jun 2020 10:46:07 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c08:474f:e61d:6947? ([2601:647:4802:9070:4c08:474f:e61d:6947])
        by smtp.gmail.com with ESMTPSA id o1sm22040841pfu.70.2020.06.24.10.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 10:46:06 -0700 (PDT)
Subject: Re: [PATCHv3 3/5] nvme: implement I/O Command Sets Command Set
 support
To:     Keith Busch <kbusch@kernel.org>
Cc:     Niklas Cassel <Niklas.Cassel@wdc.com>,
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
 <20200623221012.GA1291643@dhcp-10-100-145-180.wdl.wdc.com>
 <b5b7f6bc-22d4-0601-1749-2a631fb7d055@grimberg.me>
 <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e59e402b-de74-e670-59d1-a6c51680a31d@grimberg.me>
Date:   Wed, 24 Jun 2020 10:46:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624172509.GD1291930@dhcp-10-100-145-180.wdl.wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 6/24/20 10:25 AM, Keith Busch wrote:
> On Tue, Jun 23, 2020 at 04:17:30PM -0700, Sagi Grimberg wrote:
>>
>>>>>> -		len = nvme_process_ns_desc(ctrl, ids, cur);
>>>>>> +		len = nvme_process_ns_desc(ctrl, ids, cur, &csi_seen);
>>>>>>     		if (len < 0)
>>>>>>     			goto free_data;
>>>>>>     		len += sizeof(*cur);
>>>>>>     	}
>>>>>>     free_data:
>>>>>> +	if (!status && nvme_multi_css(ctrl) && !csi_seen) {
>>>>>
>>>>> We will clear the status if we detect a path error, that is to
>>>>> avoid needlessly removing the ns for path failures, so you should
>>>>> check at the goto site.
>>>>
>>>> The problem is that this check has to be done after checking all the ns descs,
>>>> so this check to be done as the final thing, at least after processing all the
>>>> ns descs. No matter if nvme_process_ns_desc() returned an error, or if
>>>> simply NVME_NIDT_CSI wasn't part of the ns desc list, so the loop reached the
>>>> end without error.
>>>>
>>>> Even if the nvme command failed and the status was cleared:
>>>>
>>>>                   if (status > 0 && !(status & NVME_SC_DNR))
>>>>                           status = 0;
>>>
>>> This check is so weird. What has DNR got to do with whether or not we
>>> want to continue with this namespace? The commit that adds this says
>>> it's to check for a host failed IO, but a controller can just as validly
>>> set DNR in its error status, in which case we'd still want clear the
>>> status.
>>
>> The reason is that if this error is not a DNR error, it means that we
>> should retry and succeed, we don't want to remove the namespace.
> 
> And what if it is a DNR error? For example, the controller simply
> doesn't support this CNS value. While the controller should support it,
> we definitely don't need it for NVM command set namespaces.

Maybe I mis-undersatnd the comment, but if you see a DNR error, it means
that the controller replied an error and its final, so then you can have
extra checks.

I think the point here is that if we got a non-dnr status, we should not
take any actions on this namespace because we need to retry first
(either because the controller is unavailable or it needs the host to
retry for another reason).

>> The problem that this solves is the fact that we have various error
>> recovery conditions (interconnect issues, failures, resets) and the
>> async works are designed to continue to run, issue I/O and fail. The
>> scan work, will revalidate namespaces and remove them if it fails to
>> do so, which is inherently wrong if these are simply inaccessible by
>> the host at this time.
> 
> Relying on a specific bit in the status code seems a bit indirect for
> this kind of condition.

I actually think this approach covers exactly what we are trying to
achieve. But I'll let others comment on this.
