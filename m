Received: from sonic302-20.consmr.mail.ne1.yahoo.com (sonic302-20.consmr.mail.ne1.yahoo.com [66.163.186.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9558F408626
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153264; cv=none; b=qeqfyZmECB/MmSL3Eq/1pFh4vik0ed89aRvw2OLu3LkGlQUuITnkaKrsQPP7G7eb6sYo4Xg0kdxilfVSQoiGogUoUbKZ0tDXKnxhe7CW7J9emEtG5oszybUXCU2rFaLkzBl/YE6CBf4LiW3Fy+LUdjOL9ENcUP/sT/vwULkBZT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153264; c=relaxed/simple;
	bh=k5XBrirsewOk0bYeHl+mVt/drRgh529DkzvnTltjE7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHVpHBcQR60U16s0Qq0BTfCi+fDAF7BdN77bTFOZSV8nh8HnyVW88r8uGebqtr0XHsWnjMbR9btT2i1J5p85rCmNoxnhnMPdvRIksaayqjCzjMd463TjC+sVecVnOQdh0IKV+lxhZiIqtTb2QEqS726D0pzT9/wjnilrYrHey3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=C51rqcgk; arc=none smtp.client-ip=66.163.186.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="C51rqcgk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790153250; bh=NcgmHyObDPpqZHRTCkJHAaY257ncqyTPIPwFVsPR8Zc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=C51rqcgko0DtmwAVsTgNtfKvpS0NJQPJdm/B+7H4zYHEripq4EDL1H0V6RX1QMf+1W9pI+vCYtuC0Dk9S57wotNW+xaehDVUC1YJpUTzxpcdUzuUbySaO4mhObFifV7bdEjl0ssAiJFOmv2wHKmGCvWdGrh+ytYHHWp2vG8GqMMKRwMY6ZoxxwQjLW0aP+JJ8sJ5/8GgeLfI5d5+5uYf2hEw/IfzrAKoKOeatLxalXD/MxIwxmnUTaZ8Ha3QPAb4qvclX9ny12kzgDqr5PAvec+wmTFqUtyuP1xLTQJQNxMqzRmVF876bdXS6h2qW/o6xlUr+RHQDBHUx9DMq3P3IA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1790153250; bh=meCRTTOLEtolKExWYJFVMtIN0oCNDGWLYlUCYZ7POE0=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tB9r8gqlYjMvSsddcV6Ip3tdeYCCMAOx/GwQTr/GxTid0udc9/7uZtGGiW1HsQIXIbQ2c4GT7VZMk1JNIrdP/iOXYif7snGAKFVp4Qrp6YZwulVYEntqV1AuXl/nNHVjcnOE2F+c/atw3LgF1tf0jvDZM5w49fmV475yYtr3dGP/bWtN0hYDPdmG6ci4wcg1pQHh6WDhbpp+rk3R5JO5/fV2G0+T8oDCEeqY0xmOF2+5gfOqat/6h1YxkFpU3fAWvvBbMccAyBQf9SHA9zaH50FdppyVKifWCiOUy1Twid13oOivCIywSug2fHZdhiKObWWnpbOEYloNsIjSeb3bRA==
X-YMail-OSG: hS7OkDYVM1lbk.K6tguf3xh5121gBNsnWCsM39FV1Pfq6rLABi2ZbVwI3lH9sI.
 0pB2Pf0tH5ts_BlMmR2rcyajaeWAl_07jxiQFSjsJj.Ayv5up4B.DwrOpeyPgAQ_CNRUkjTUWKWr
 7E3PDrt2L4r3zlJjvXy.QEHGfAETHoK4Kyu4xJnzzc0n7jyKXKTRUEpk3Aa9F.UBadlACGinWzEE
 CHcPBlLuSwOIMnrwC18KVD54HdGPpsoSTv7pZ3RADH3e1ztl8DClX313Aouw18A_K.yZ8Eg9mtOi
 kyzarGrkjM600r_q.kaegZ22N425y8tT_4kwYUp9IiEDqcwufhGHla.lCT33N0HbkYg4lRA_j66j
 LNOVwbM268rpRPOEhCJkHDZgXicGdt.TEG96rOVkRNV8A9JxH7o0cxAfSZaUZgACfvo7gYYDj8Pe
 FOOT.c0osIOuSU2NVJoz1J3nJ_uFA7SJzYnvgMy5kYKr6tSphyAq_5VZF18dsbZhJY3qFNtC5Zo_
 C5boSIutW02NkVflqZud.3KS9SU_PqAmuRbbxTm87q7ZhDYp1Ful48NH2bJzwv9DQYcy_B0apkrl
 gh2PKsntCgDylM6Za6ImbJZ5z3SHyxGXT.gFcMmd8OdZGxkCKoZyOq8_kRBkLfEfgxxLU6bgtHfN
 kGdFuipCM5e63eYRCxo0tMzNZhnPFihdBFDtIUjQRz8hzjIm3iJt14IuJU6iqbcBSDWxl0Q4f5E4
 eQ2sCAN75H.ToLzfFQk5CGa54W91WjP3zSZAIEYNPKndLQrTiCl0EYMIAw3Df3u24enV6vJO9Sb8
 NbeENDHfSt_h6DnBs9.vBw6MlWiDm1Pgw0cCPEWCcqICC6nR2EGAv4UeJO6pnK2o9pihZk7bfPJ1
 6vR92dnv66fSsrIgXuOGYvUw8DghrqiLEx1Er37CVTR3xOiB4aE9k1Waozj4QNdFbKkP8G90GAGI
 P4Mlf45ABQAE2FbLkkqidjguq_5yWQqWPADjTRnEueCvEyHToYz7yOhVUYRv7x0LRJT4Rxs2wOGH
 1dRRHImQuCJeA69H_YWWU_vrnwdMDOAi4O9MtHZfVQJOZfqjSZlfvTZ_UIE9k4iSQgIKcbH4jW.q
 21FmC6BLIx3Vvg5SIZ4SoxOtRhvNsNh2unglRkDX0wlFHjTE.fBN4xOuKmYp06YVq9nJzljtKig7
 yWdziZDYKlnjigM1v.xY46MqHdXKQKy9YIy9cDKabKSWkcYRkfTPOsPvBYw.K00fG8saiUXvEAdN
 jI3StOkTeq3HI0eBbYWf9F0xALUJXkrN5r.hSqtgGDC98wzUXCyWUAE84yza8I71AOZfc8HwgGww
 _T45TO.kNeSIA4hUt_W13bvHZtCmLhCPXDeDFK3XHDZvXRrWYmgv1rgobwMyBziNV8kb.YqxShiI
 x_u2rNv0whgHkwxtlmbxQa46od1OL.1MsiaszAK33SDALqAz3sjYPIx3Nhg8jMFryAsnDwklobRE
 GqwoXrJPphrjiwnwbBExQ_M78dCL1kixwPDScszB5aypejQ05PsWP5bu3o13eOo_EpIe_u7Y7fJR
 7tL1VATbUGnVYtCN6HQi7NQXY94oAoLIaQ7OA..WosHk2G_pPuxww.JhYqUzW4XDMv.hfZb6Itjz
 wnPHqzeAhJz5_62EDJ_biwRLnROrPQftNj2KnBBYwOj6c7Da7hv5rxxZ2X3zScAdZw_heAlQq7tk
 RdEHozqnEsDJkon_Z8szBk1.wR0V1jGUBzdUMgFGKeR4.JxD0mJMOOGc4hEqQpKUTzRBDux8xJn7
 CcoxExcVX0182VtzyKaC3x4WlCIRtovLWGS94tYP7oQNOM0lArR6b19NNoxW1ers2py53_IYYJai
 9WjPLs2qkeG1K506fNkDcoqiOCUxsH33hlYNLacz_DlcTk9ZPQuOw3tm8P5hoV7W.tEgN6Wr_KlI
 NgkITyJuVdCPZsYEi9OetVMeW05ZOzexdzDn9BX8oY98rS18ByUK14_JsUHR4mhakmAb7jiZkM7C
 WYccDTdttkFJpjmvqx84Efn7s0KCe2A08sm_omLBTnS5QQTJ5_MwQVkc3o1uivAEvnmKnDGtO5gE
 cIYoloktCxQdROwI76WzzNSZRGWBDPfUQq9hYD56oqTZP1XrcQiX0EkJloppn_2JGavXc.zqxR2e
 vDL1yHLH.mRrZhPyo._lJ4JJwA9J44841CKv4RZZTkkB8QHgfKbslJQ6RdDTSS109.cEnZ24gVvZ
 cxW9aVm7RfYn9TdZADGwra19fwfg18ls7fznumWH9aXYGMbDqmpAR0n4iUe2AI.qpcK3BIF6gqbW
 SVW280CHSRAJ5E.C7hQ--
X-Sonic-MF: <userm57@yahoo.com>
X-Sonic-ID: 9a5224fb-181d-457d-8fa6-6b9c25e5ed5b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 23 Sep 2026 08:47:30 +0000
Received: by hermes--production-ne1-6dbcb84f44-zgjzx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 12d3746fbcd0ce1b59c1d9c5afd6d363;
          Wed, 23 Sep 2026 08:26:50 +0000 (UTC)
Message-ID: <cdb86fe1-8e5f-4781-8773-3e199e79a770@yahoo.com>
Date: Wed, 23 Sep 2026 02:26:48 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/33] block/swim: Fixes and improvements
To: Finn Thain <fthain@linux-m68k.org>, Jens Axboe <axboe@kernel.dk>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Joshua Thompson <funaho@jurai.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 Omar Sandoval <osandov@fb.com>
References: <cover.1788513996.git.fthain@linux-m68k.org>
Content-Language: en-US
From: "Stanley J. Johnson" <userm57@yahoo.com>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26577 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Tested-by: Stan Johnson <userm57@yahoo.com>

This patch series was successfully tested on a Mac IIci.

On 9/4/26 3:26 AM, Finn Thain wrote:
> I recently had a need for the 'swim' driver but found that it was too buggy
> to be useful for my purposes. I had two aims in mind--
> 
> Firstly, I needed this driver to help me test my new BMoW Floppy Emu for
> emulation correctness. Being that Linux is open source and MacOS is not,
> this driver should be ideal for that.
> 
> Secondly, I needed to realign the heads in some disk drives. The swim driver
> has most of the code needed for a feedback loop for manual re-alignment, so
> I wrote the remaining code and pushed it to a repo here:
> https://github.com/fthain/linux/commits/swim/
> 
> These patches fix all the bugs I found. They improve stability,
> compatibility and performance. Additional patches improve source code
> quality by removing redundant code and cleaning up a bit.
> 
> This patch series was successfully tested on the following systems.
> 
> Mac Quadra 650 - SWIM 2 with Mitsubishi FDD
> Mac LC III     - SWIM 2 with Mitsubishi FDD and Sony FDD
> Mac Quadra 700 - SWIM with Sony FDD
> Mac IIvx       - SWIM with Sony FDD
> 
> ---
> 
> Changed since v1:
>   - Patches 1/31, 19/31, 23/31 were revised as per Laurent's remarks.
>   - Some minor improvements to patches 9/31, 13/31 and 16/31.
>   - Added patch 24/32 to fix a bug causing silent IO corruption instead
>     of an IO error.
> 
> Changed since v2:
>   - Reviewed-by tags were dropped from patches 1/32, 9/32, 13/32 and 16/32
>     because of unreviewed changes.
>   - Better assembly code in patch 13/32.
>   - Patch 23/32 improved upon to reduce excessive interrupt latency when
>     medium errors are encountered.
>   - Patch 7/32 was split in two, and readability was improved as requested
>     by Geert.
>   - Geert's acked-by tag was added.
> 
> ---
> 
> Finn Thain (33):
>    swim: Assert strobe with stable outputs
>    swim: Select appropriate drive once only
>    swim: Enable the drive when probing
>    swim: Don't disable drive after every sector
>    swim: Perform ISM/IWM mode switching according to specs
>    swim: Configure parameter memory
>    swim: Refactor SWIM setup
>    swim: Enable clock divider only where appropriate
>    swim: Don't start motor until medium is present
>    swim: Recalibrate when drive is probed
>    swim: Add track zero recalibration delay
>    swim: Handle FIFO timeout error
>    swim: Simplify return value initialization
>    swim: Check for CRC errors
>    swim: Check error register during sector read
>    swim: Don't use the mark register to read data
>    swim: Fix buffer overflow
>    swim: Convert to blocking queue
>    swim: Remove redundant RELAX actions
>    swim: Deduplicate polling loops
>    swim: Check drive ready bit
>    swim: Revisit delays
>    swim: Remove pointless mode0 register write
>    swim: Don't needlessly re-read sectors
>    swim: Don't search beyond the first data mark
>    swim: Remove pointless specifiers
>    swim: Move swd initialization
>    swim: Add some helpful references
>    swim: Remove unused macro definitions
>    swim: Clean up whitespace
>    swim: Define macros for constants
>    swim: Define symbols for constants
>    swim: Unexport global symbols
> 
>   arch/m68k/mac/config.c   |  31 ++-
>   drivers/block/swim.c     | 451 ++++++++++++++++++++-------------------
>   drivers/block/swim_asm.S | 356 +++++++++++++++---------------
>   3 files changed, 452 insertions(+), 386 deletions(-)
> 
