Received: from outgoing.selfhost.de (mordac.selfhost.de [82.98.82.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5698586255
	for <linux-block@vger.kernel.org>; Wed, 28 Feb 2024 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.98.82.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155965; cv=none; b=OdM8qmggQv6+wSRDNTiswKXquHvqJZNrEK9saoEYCIRO2YgLkWO46HNrW4bw7/X4pBe/OwYhZrV5YAFd7haIRYpJ+YhdtwP7PGpWhXRDpWa5mX1Jw3su0OjV7k442+C18HFJyhBBH4UNjy+JoNARVC+WGph9S+YSK62Mk26cemc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155965; c=relaxed/simple;
	bh=YZFbjwaS7EZ82Bo+AEk8uyNZ9d9OwKHxLaI27fIsRCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZiVz3LmDstnxW1LJxtoqNcpEMoWYMK5tD+punOP9+KoJRrYvZMal7FCx+qvAqH/hrBUNTlIhjXmeupu6zn0gwb9CuzkOgrdSjG4ZkmzaFQ53iGnzXgrfTaHModM6ir+wEhB+Fhu2OK6I++yGFOzVHhfxpSx/7CDftY+b46m3k8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de; spf=none smtp.mailfrom=afaics.de; arc=none smtp.client-ip=82.98.82.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=afaics.de
Received: (qmail 3203 invoked from network); 28 Feb 2024 21:32:39 -0000
Received: from unknown (HELO mailhost.afaics.de) (postmaster@xqrsonfo.mail.selfhost.de@79.192.199.18)
  by mailout.selfhost.de with ESMTPA; 28 Feb 2024 21:32:39 -0000
X-Spam-Level: ****
X-Spam-Report: 
	*  4.0 RCVD_IN_PBL RBL: Last ext relay in Spamhaus PBL (Non-MTA IPs)
	*      [2003:e3:1f31:6503:68fd:ffff:fe6f:e76 listed in]
	[zen.spamhaus.org]
	*  0.0 HELO_NO_DOMAIN Relay reports its domain incorrectly
	*  0.0 DMARC_MISSING Missing DMARC policy
	*  0.0 KHOP_HELO_FCRDNS Relay HELO differs from its IP's reverse DNS
Received: from [IPV6:2003:e3:1f31:6503:68fd:ffff:fe6f:e76] (p200300e31f31650368fdfffffe6f0e76.dip0.t-ipconnect.de [2003:e3:1f31:6503:68fd:ffff:fe6f:e76])
	by marvin.afaics.de (OpenSMTPD) with ESMTP id cc23ecd1;
	Wed, 28 Feb 2024 22:32:34 +0100 (CET)
Message-ID: <acb5b4db-ef01-4edd-b97c-d8f7e2b241f2@afaics.de>
Date: Wed, 28 Feb 2024 22:32:32 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: RIP on discard, JMicron USB adaptor
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Harald Dunkel <harald.dunkel@aixigo.com>
Cc: Keith Busch <kbusch@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 linux-block@vger.kernel.org, linux-usb@vger.kernel.org
References: <70bc51d7-c8a2-4b06-ab7a-e321d20db49a@aixigo.com>
 <62296d89-f7e6-4f54-add8-35b531dc657c@rowland.harvard.edu>
 <Zd9Xbz3L6JEvBHHT@kbusch-mbp> <yq1sf1c1h0x.fsf@ca-mkp.ca.oracle.com>
From: Harald Dunkel <harri@afaics.de>
Content-Language: en-US
Autocrypt: addr=harri@afaics.de; keydata=
 xsBNBFIHbdABCACYHRLHGdFRk7bWkgdPhDLin6jLIS0ppegsx0Vc9STFyiHFUW+6HU9ZYTpO
 f2qbcWlE3YJYacy6zOiiTjYX31quhvGrP3UJXKjXsAp7CFsMxRJUhm20Ph0nCl/Oed9SDNXN
 HQJwHoOVWrsu/sGxNTfjCWRJleBE11P+TuuLOAP9dbqFbWhmkTsE9Lp9d16Ak77MWmWWxBvD
 cBsUuC2GOYDfFOPM3j16w7aw4Y9GI2B5QzFiHvOR/hCazfDEMQAlaHMm6sH8uzrjNEtB5dvm
 vxF8j/IpvsuvWGhZ68rej2gPwoVrRTEBaYslW8/5dm8o1HuTkuLqxhNTcvYWyV8uKRtTABEB
 AAHNH0hhcmFsZCBEdW5rZWwgPGhhcnJpQGFmYWljcy5kZT7CwHoEEwEIACQCGwMCHgECF4AC
 GQEFAlQYLhUFCwkIBwMFFQoJCAsFFgIDAQAACgkQCp4qnmbTgcu7Fwf/RoWwNDxJPD96vBFb
 Jzfta9qVA0JpbKoMAnNY0tDWiF5Ur8UY/tv/RDVV44Vx3Ef0fzQZN0CtHsNfAKO+KXBMUiuT
 AP4AadpaIwYMo8v+SmPzJSUxWgBm6IsHwn1udXRdEgdR9guWkLPRGCK3x84sorAOUnUHJHkq
 UrDFQUNfNA9lqM7ttunfVtG4SaqcLEOpJ1s/aMUsEODlP/lws42VjubIVg403cMIgvqs5cT8
 EjLDNqCwEoWZRhfpg5x3D5uNDNWSW70Z+6Knicbi129QIu4HtSnfrxiuvHz2LLPFOVQuj8h4
 TPT6tkfIURKipFXoIC3YiK8f94rFO3q86oNJUs7ATQRSB23QAQgA27gQiXZ96pbJkGoz1RWX
 T8WSQJ5TWVJyf4eswoVI8Ffk5vLE+xPpAYEDkL7JYGCvBN1BKrcaZzDy8Irfys6bHI3JmVVi
 ZloSkVS8QL7pQGfp74VT3NvDjK6LDe9QMv8Rb45laSRD5XCGRMTxz9pwu3vNcOPCfV5nmbyB
 /6h4/bguFH1+6aGz6HyC8v/tjhL6+cY329inJ+vWVJYssweMIIYpssUtDaPKZO0080toLLrt
 KuVgiUb9llbmZgKGElRjwgGT8AUXDRFCzn0ws/nuGNw0L+EdCI3VdZSK5KMEO34vZq7iNeM1
 ZVnPVZAbHheR30NFKTgrwvlt8G7blHJPWwARAQABwsBfBBgBCAAJBQJSB23QAhsMAAoJEAqe
 Kp5m04HLiiEH/jlKumVyQrOxH58iQFzVDthDfJdBLmnDlfVx2Dzn60vc5To6yJ3fwO21s3xC
 /LW9aZSfDueV0nWU4/Wow/X5GEH90Vc1sFoeSZb/GW03vsO1n/OFIVlv9GQv+RviWMDEwKKx
 CMvdqUlVblWf1iT/ngPN0YawKGF0Dgn8TRzfL/Tq9muwNUaONzz8PWBUIm1+8JDZszYLzLoz
 YiY0usL4GH9BCeW6XG2Q6j4cpyOQZ0VKiBs1Rh+dmswn+iXLfi08Q0IxYAD6wjHdJTBD9pE9
 5Uj8/1spt51FBAAIP+7sd2mpAvsNnojatuOgjBmBxFwiOKeyDNe1wvKr4dsRheOLV8M=
In-Reply-To: <yq1sf1c1h0x.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

On 2024-02-28 21:19:25, Martin K. Petersen wrote:
> 
>> In the code comments above the WARN, this condition indicates "the
>> discard granularity isn't set by buggy device driver". The block layer
>> needs this set if your driver also sets the max_discard_sectors limit.
> 
> Please provide the output of:
> 
> # sg_readcap -l /dev/sdN
> # sg_vpd -l /dev/sdN
> # sg_vpd -p 0xb0 /dev/sdN
> # sg_vpd -p 0xb1 /dev/sdN
> # sg_vpd -p 0xb2 /dev/sdN
> # sg_opcodes /dev/sdN
> 
> Thanks!
> 

I am not in the office anymore, so I cannot plugin the USB device to run
the commands you requested. First thing tomorrow in the morning, promised.


Regards

Harri
