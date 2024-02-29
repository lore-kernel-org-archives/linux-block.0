Received: from outgoing.selfhost.de (mordac.selfhost.de [82.98.82.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AE94594B
	for <linux-block@vger.kernel.org>; Thu, 29 Feb 2024 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.98.82.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709192725; cv=none; b=Wb9raXGpSee8EkZylhAsRizWzochjL3tfpSGOp9D6XX4DjD2m/PFVdDwDL1TvaF8NNRkP4UhxYP3QDOJP1N4tfRvdv8CynKPQdYVlOYb+PbJWLqcpOkN5e8yVdqyyaOUQ6COYlaA5rea/VOLzzDfCeVfdTJQ98qx1dPUbMLFoBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709192725; c=relaxed/simple;
	bh=swhnKb1Lrg7YCL9NUp9cw43A99bJtWKjli84bTdku6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucEax2nt7AmkVIm56CiuEgoYJcaQrQaV5+UMIzaZewBXlCQpGRjCsJsogSRkuh1dPw4yifVk58dJwrKFLHVwTICRM7jMMARgpeLbL17395F4thCesZHohCxgf40NtaM2rJo+RYN1T534xuvq4H4Ij/uYhjgXhwmKyypp9MLJ7nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de; spf=none smtp.mailfrom=afaics.de; arc=none smtp.client-ip=82.98.82.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=afaics.de
Received: (qmail 19467 invoked from network); 29 Feb 2024 07:45:20 -0000
Received: from unknown (HELO mailhost.afaics.de) (postmaster@xqrsonfo.mail.selfhost.de@79.192.199.18)
  by mailout.selfhost.de with ESMTPA; 29 Feb 2024 07:45:20 -0000
X-Spam-Level: ****
X-Spam-Report: 
	*  4.0 RCVD_IN_PBL RBL: Last ext relay in Spamhaus PBL (Non-MTA IPs)
	*      [2003:e3:1f31:6503:8865:8fff:feb7:694d listed in]
	[zen.spamhaus.org]
	*  0.0 HELO_NO_DOMAIN Relay reports its domain incorrectly
	*  0.0 KHOP_HELO_FCRDNS Relay HELO differs from its IP's reverse DNS
	*  0.0 DMARC_MISSING Missing DMARC policy
Received: from [IPV6:2003:e3:1f31:6503:8865:8fff:feb7:694d] (p200300e31f31650388658ffffeb7694d.dip0.t-ipconnect.de [2003:e3:1f31:6503:8865:8fff:feb7:694d])
	by marvin.afaics.de (OpenSMTPD) with ESMTP id 177fc628;
	Thu, 29 Feb 2024 08:45:20 +0100 (CET)
Message-ID: <7a10ff3b-0c4c-4aa3-8218-02d5f27ab062@afaics.de>
Date: Thu, 29 Feb 2024 08:45:19 +0100
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

On 2024-02-28 21:19:25, Martin K. Petersen wrote:
> 
> Please provide the output of:
> 
 > # sg_readcap -l /dev/sdN
 > # sg_vpd -l /dev/sdN> # sg_vpd -p 0xb0 /dev/sdN
> # sg_vpd -p 0xb1 /dev/sdN
> # sg_vpd -p 0xb2 /dev/sdN
> # sg_opcodes /dev/sdN
> 
> Thanks!
> 

% sg_readcap -l /dev/sdf
Read Capacity results:
    Protection: prot_en=0, p_type=0, p_i_exponent=0
    Logical block provisioning: lbpme=0, lbprz=0
    Last LBA=2000409263 (0x773bd2af), Number of logical blocks=2000409264
    Logical block length=512 bytes
    Logical blocks per physical block exponent=3 [so physical block length=4096 bytes]
    Lowest aligned LBA=0
Hence:
    Device size: 1024209543168 bytes, 976762.3 MiB, 1024.21 GB

% sg_vpd -l /dev/sdf
Supported VPD pages VPD page:
    [PQual=0  Peripheral device type: disk]
   0x00  Supported VPD pages [sv]
   0x80  Unit serial number [sn]
   0x83  Device identification [di]
   0xb0  Block limits (SBC) [bl]
   0xb1  Block device characteristics (SBC) [bdc]
   0xb2  Logical block provisioning (SBC) [lbpv]
   0xde
   0xdf

% sg_vpd -p 0xb0 /dev/sdf
Block limits VPD page (SBC):
   Write same non-zero (WSNZ): 0
   Maximum compare and write length: 0 blocks [Command not implemented]
   Optimal transfer length granularity: 8 blocks
   Maximum transfer length: 65535 blocks
   Optimal transfer length: 65535 blocks
   Maximum prefetch transfer length: 65535 blocks
   Maximum unmap LBA count: -1 [unbounded]
   Maximum unmap block descriptor count: 63
   Optimal unmap granularity: 0 blocks [not reported]
   Unmap granularity alignment valid: false
   Unmap granularity alignment: 0 [invalid]
   Maximum write same length: 0 blocks [not reported]
   Maximum atomic transfer length: 0 blocks [not reported]
   Atomic alignment: 0 [unaligned atomic writes permitted]
   Atomic transfer length granularity: 0 [no granularity requirement
   Maximum atomic transfer length with atomic boundary: 0 blocks [not reported]
   Maximum atomic boundary size: 0 blocks [can only write atomic 1 block]

% sg_vpd -p 0xb1 /dev/sdf
Block device characteristics VPD page (SBC):
   Non-rotating medium (e.g. solid state)
   Product type: Not specified
   WABEREQ=0
   WACEREQ=0
   Nominal form factor not reported
   ZONED=0
   RBWZ=0
   BOCS=0
   FUAB=0
   VBULS=0
   DEPOPULATION_TIME=0 (seconds)

% sg_vpd -p 0xb2 /dev/sdf
Logical block provisioning VPD page (SBC):
   Unmap command supported (LBPU): 1
   Write same (16) with unmap bit supported (LBPWS): 0
   Write same (10) with unmap bit supported (LBPWS10): 0
   Logical block provisioning read zeros (LBPRZ): 0
   Anchored LBAs supported (ANC_SUP): 0
   Threshold exponent: 0 [threshold sets not supported]
   Descriptor present (DP): 0
   Minimum percentage: 0 [not reported]
   Provisioning type: 0 (not known or fully provisioned)
   Threshold percentage: 0 [percentages not supported]

% sg_opcodes /dev/sdf
   SAMSUNG   MZVLB1T0HALR      3108
   Peripheral device type: disk
Report supported operation codes: Illegal request, Invalid opcode


Hope this helps
Harri
