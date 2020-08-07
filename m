Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35BEC433E0
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 17:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17FC221E5
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 17:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgHGRTz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:19:55 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52124 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgHGRTy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Aug 2020 13:19:54 -0400
Received: by mail-pj1-f67.google.com with SMTP id c6so1211708pje.1
        for <linux-block@vger.kernel.org>; Fri, 07 Aug 2020 10:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BleyKxaoKX4w+9G8f0gdJ4kFsHgpTWDKDGAXl2lpAl0=;
        b=ihS0Udte4KaME0dwBtpXqaUVJu6u5HHeuA+fXFfaTHtks3ugSIg/Imt+8slzp6rKML
         FZtG25Vc/xZoQJ3wLuQyzC6VhtNqZcqfjnIxOjWicsMHQrLhpdImrp1M7B/1faMpVFi8
         1rb83pcdARNQStdhjw5e1Kg+n3Usj5N13Ez9harHQONSPvWBm9kONN6yAAdHoguB/fNq
         hjsMDvFko1IVn4FKwxOF4FbPpwFg+FEUNaB03SF0wVacjxOuPTuxKZ/3T6EN0w9JAHR0
         wX3i8JEoKyYi2MrIOYe9QDB0lPpchEuerDmbnLAiMWyvMCUkwnsHAKEEvhVR+hT28kDW
         Zcow==
X-Gm-Message-State: AOAM5317Jc+1NMqXkYm5Guk6Mee/d5d3L18wtMy/YQsgBtewxPa8zE4N
        jbj6sUiixDC4z7p8/5ak/98=
X-Google-Smtp-Source: ABdhPJzZDyVxEsiUBSq+9eTjTln3b83Rm5krk4VI/4+RC9HimfmobBKYf1pZ2uncU1jWY3dPiN4qgQ==
X-Received: by 2002:a17:90a:230d:: with SMTP id f13mr13311634pje.116.1596820794059;
        Fri, 07 Aug 2020 10:19:54 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dec:a6f0:8cde:ad1c? ([2601:647:4802:9070:3dec:a6f0:8cde:ad1c])
        by smtp.gmail.com with ESMTPSA id y135sm14249922pfg.148.2020.08.07.10.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 10:19:53 -0700 (PDT)
Subject: Re: [PATCH v2 3/7] nvme: make tests transport type agnostic
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-4-sagi@grimberg.me>
 <BYAPR04MB4965624DFCE5A870BDE20A4686490@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ecf895c8-c009-2327-cd37-e8838b7e5e38@grimberg.me>
Date:   Fri, 7 Aug 2020 10:19:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965624DFCE5A870BDE20A4686490@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> diff --git a/tests/nvme/002 b/tests/nvme/002
>> index 999e222705bf..8540623497c7 100755
>> --- a/tests/nvme/002
>> +++ b/tests/nvme/002
>> @@ -21,7 +21,7 @@ test() {
>>    
>>    	local iterations=1000
>>    	local port
>> -	port="$(_create_nvmet_port "loop")"
>> +	port="$(_create_nvmet_port ${nvme_trtype})"
> Is there a way to directly use nvme_trtype especially in rc ?
> if not disregard this comment.

I didn't want to do this, because a test can create multiple ports.
But maybe it could have a default value?

>> @@ -33,10 +33,10 @@ test() {
>>    		"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
>>    	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-1"
>>    
>> -	_nvme_connect_subsys "loop" "blktests-subsystem-1"
>> +	_nvme_connect_subsys ${nvme_trtype} "blktests-subsystem-1"
>>    
>>    	local nvmedev
>> -	nvmedev="$(_find_nvme_loop_dev)"
>> +	nvmedev="$(_find_nvme_dev)"
>>    	cat "/sys/block/${nvmedev}n1/uuid"
>>    	cat "/sys/block/${nvmedev}n1/wwid"
> 
> Since we are touching nvmedev can we move above uuid and wwid to
> a wrapper something like _nvme_show_uuid_wwid ${nvmedev}n1 ?

Doesn't help the patch set cause, so it can be added incrementally.

> 
>>
>> @@ -36,12 +36,12 @@ test() {
>>    
>>    	loop_dev="$(losetup -f --show "$TMPDIR/img")"
>>    
>> -	port="$(_create_nvmet_port "loop")"
>> +	port="$(_create_nvmet_port ${nvme_trtype})"
>>    
>>    	for ((i = 0; i < iterations; i++)); do
>>    		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
>>    		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
>> -		_nvme_connect_subsys "loop" "${subsys}$i"
>> +		_nvme_connect_subsys ${nvme_trtype} "${subsys}$i"
> Same here for nvme_trtype as first comment.
>>    		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
>>    		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
>>    		_remove_nvmet_subsystem "${subsys}$i"
>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>> index 6d57cf591300..191f0497416a 100644
>> --- a/tests/nvme/rc
>> +++ b/tests/nvme/rc
>> @@ -6,6 +6,9 @@
>>    
>>    . common/rc
>>    
>> +def_traddr="127.0.0.1"
>> +def_adrfam="ipv4"
>> +def_trsvcid="4420"
>>    nvme_trtype=${nvme_trtype:-"loop"}
>>    
>>    _nvme_requires() {
>> @@ -62,8 +65,8 @@ _cleanup_nvmet() {
>>    	for dev in /sys/class/nvme/nvme*; do
>>    		dev="$(basename "$dev")"
>>    		transport="$(cat "/sys/class/nvme/${dev}/transport")"
>> -		if [[ "$transport" == "loop" ]]; then
>> -			echo "WARNING: Test did not clean up loop device: ${dev}"
>> +		if [[ "$transport" == "${nvme_trtype}" ]]; then
>> +			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
>>    			_nvme_disconnect_ctrl "${dev}"
>>    		fi
>>    	done
>> @@ -87,14 +90,20 @@ _cleanup_nvmet() {
>>    	shopt -u nullglob
>>    	trap SIGINT
>>    
>> -	modprobe -r nvme-loop 2>/dev/null
>> +	modprobe -r nvme-${nvme_trtype} 2>/dev/null
>> +	if [[ "${nvme_trtype}" != "loop" ]]; then
>> +		modprobe -r nvmet-${nvme_trtype} 2>/dev/null
> This is not from your patch but I'd keep the error message it has
> turned out to be useful for me when debugging refcount problem
> especially unload and load scenario.

Again, I'd like to avoid doing things that are outside the scope
of what this is trying to achieve because it is not a small change.

We can add it incrementally.
