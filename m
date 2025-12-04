Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C532ECD1B
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865677; cv=none; b=ce8NS5dHc54/Ng972p1YkAlLyqpclv3Nfo5KlOTuX+Jw8E97LofDEp2EL+owN6gnH/bM4hOQMp46QV0tkoLA9TE1eGytIlWUCcXJ/JEqLXxiFP8AeSocvL/FnoM7+STSTVq0fqimU82f/fDo50tvpcfITj99s9H6lP0fM6D+Ufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865677; c=relaxed/simple;
	bh=inAE9u7NLIvk2tGdAxi9Qebj0kxeKD/BZGEVb9IagFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3qQNvx6dPaokAJy0YPY9+QSG2fj9O6e1tAerUdCd2gE0djEVPCIoDOn+hFebms2hI6sBaFdUMpoGvcL5LtLHWuotRA1SdH4VwLAsh5utCNjXbCyMQ+d4l1T5pQmcXGC7wwVEQR2och7YHB/23G/2C3L+Ctd53n4nmSLnBdo4CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=D6l/7XIX; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="D6l/7XIX"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dMg0V2SCKzlxJpK;
	Thu,  4 Dec 2025 16:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764865672; x=1767457673; bh=OYjuhow/q7rJjceMyNP4+uTC
	Xls7+QMKRlDWvQ70DWU=; b=D6l/7XIXZHHzPN/DO4HKnwzWygPJ7nnBbIoj1kp6
	DROnJ8+nKdBH3uUikoAdAQeZfykXprh7cuJCLaW8A79XrlLDyPKNgn+smAEXeW8k
	8pc6OZd8hWikjN8KeYm+3ASQD3V4eEjpx0WmOTdHKphnA3PHNLSl23V7WPGfUnlr
	+T9Y8FSHo/WNU8PwP+HNjy1kpybTBJd91owDmL4R384YX/d9TWahFjscZs45dfB+
	orDku4imYLZ1M2nWXWD7zY/Aw6ID7/wP9WNbFDn+okgmZ5vYkxoW5bmRA3av3n+S
	Q4H6bBffBSK1B/GsG7kDfGpDaJXXstV1SCiZTG5PafgbNA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QpPn-oJrKsY6; Thu,  4 Dec 2025 16:27:52 +0000 (UTC)
Received: from [10.25.100.213] (syn-098-147-059-154.biz.spectrum.com [98.147.59.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dMg0Q5cFvzlfdfd;
	Thu,  4 Dec 2025 16:27:50 +0000 (UTC)
Message-ID: <ef6199cb-f3fb-4d69-99bc-66ab1222272b@acm.org>
Date: Thu, 4 Dec 2025 06:27:49 -1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] scsi/004: add SCSI_PROC_FS requirement
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Hannes Reinecke <hare@suse.de>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Steffen Maier <maier@linux.ibm.com>
References: <20251120012731.3850987-1-lizhijian@fujitsu.com>
 <43b4daba-3bc3-4b37-8464-324792c8b4de@suse.de>
 <17b6a4ab-1709-45e8-93da-a068192b0137@fujitsu.com>
 <2pvduxbjeccwqgfn2rlofm4aacrnublbwcav4bpcsz7eg5mimd@5tm3576mikyy>
 <82978f0c-4426-4bdf-b270-a86ef9c2d1fa@fujitsu.com>
 <gjl7kqnnziae3yumvohew7nacq4553k6lahfdefc3xrymohzgt@727qyoksolau>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <gjl7kqnnziae3yumvohew7nacq4553k6lahfdefc3xrymohzgt@727qyoksolau>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/25 1:42 AM, Shinichiro Kawasaki wrote:
> On Dec 04, 2025 / 08:14, Zhijian Li (Fujitsu) wrote:
>> Shinichiro,
>>
>> Thanks for your efforts.
>>
>> On 04/12/2025 14:00, Shinichiro Kawasaki wrote:
>>> Zhijian, thank you for finding this and the patch. I took a look in it.
>>>
>>> The test case scsi/004 checks/proc/scsi/scsi_debug/* to find out
>>> "in_use_bm BUSY:". If it finds out the keyword in the proc file, the device is
>>> still doing something with using a sdebug_queue.
>>>
>>> However, the sdebug_queue was removed with the commit f1437cd1e535 ("scsi:
>>> scsi_debug: Drop sdebug_queue"). This removed the in_use_bm that was used to
>>> manage sdebug_queue. Then, as you noted, the commit 7f92ca91c8ef ("scsi:
>>> scsi_debug: Remove a reference to in_use_bm") changed the message from
>>> "in_use_bm BUSY:" to "BUSY:".
>>>
>>> IIUC, the test case refers to/proc/scsi/scsi_debug/* to confirm that any I/O is
>>> not on-going. So, I think it can be done using the sysfs "inflight" attribute as
>>> below (not yet fully tested):
>>
>>
>> I checked out to v4.17 and tried your patch, but it doesn't seem to work as expected.
>>    
>> I added some debug messages based on your patch, as shown below:
>>
>>    41         # dd closing SCSI disk causes implicit TUR also being delayed once
>>    42         grep -F "in_use_bm BUSY:" "/proc/scsi/scsi_debug/${SCSI_DEBUG_HOSTS[0]}"
>>    43         while true; do
>>    44                 read -a inflights < \
>>    45                      <(cat /sys/block/"${SCSI_DEBUG_DEVICES[0]}"/inflight)
>>    46                 echo "${inflights[0]}, ${inflights[1]}"
>>    47                 if ((inflights[0] + inflights[1] == 0)); then
>>    48                         break;
>>    49                 fi
>>    50                 sleep 1
>>    51         done
>>    52         echo 1 > /sys/bus/pseudo/drivers/scsi_debug/ndelay
>>
>>
>> ======================
>> $ cat /home/lizhijian/blktests/results/nodev/scsi/004.out.bad
>> Running scsi/004
>> Input/output error
>>       in_use_bm BUSY: first,last bits: 0,0
>> 0, 0
>> tests/scsi/004: line 52: echo: write error: Device or resource busy
>> Test complete
>>
>> ======================
>>
>> This output indicates that even when "in_use_bm BUSY" is present, the total inflight counter is still reported as 0.
>> This suggests that the 'inflight' counter might not be capturing the state we're trying to detect.
> 
> Thank you for trying it out. It proves that my suggestion does not work.
> 
> I wonder one thing. When I just remove the while-grep for "in_use_bm BUSY:"
> check, the test case does not fail in my environment. I guess that is because
> I use rather newer kernel. I tried v6.1.118 kernel, and it passed without the
> while-grep. And my system does not boot with the kernel older than v5.15.196.
> 
> May I ask you to try the same trial in your environment? With v4.17 kernel, the
> test case should fail by removing the "in_use_bm BUSY:" check. I'm interested in
> which kernel version the test case can pass without the check (v5.10.x? or
> v5.15.x?). If the necessity of the check depends on kernel versions, we can
> limit the CONFIG_SCSI_PROC_FS dependency to older kernel versions, hopefully.
Any ongoing I/O should have finished before a new scsi_debug test is
started.

How about replacing the while loop with something like this (untested):

echo -10 > /sys/bus/pseudo/drivers/scsi_debug/add_host

The above shell command removes up to ten SCSI hosts. Removing a SCSI
host only completes after all pending I/O has finished. This should work
whether or not scsi_debug has been built as a loadable kernel module.

I do not know when this functionality was introduced. The history of my
kernel git repository goes back to 2003. I think that support for
removing SCSI hosts by writing into the add_host parameter was already
present in the 2003 version of scsi_debug.

Thanks,

Bart.
