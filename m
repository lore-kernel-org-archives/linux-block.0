Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F31B950
	for <linux-block@vger.kernel.org>; Fri, 12 Apr 2024 04:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712896990; cv=none; b=iJ4z6xOybWg8/KiYlSV3+C21tY8MLFLji0Qk1bYtH5F4+nbL0HTK8Gbfp6GYSzGiLq2ztTz9RhtdpTxRiVT2JT0vbHE+QvRH1cYi92sg4gwNOnadys3JKeJ8Wep0OTaGt9OIecdnjLsFkNfAw6M3e3uOfcafczKNhlR3IAJ15Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712896990; c=relaxed/simple;
	bh=d5HYiqnpT4PSlmypMIwoJY+BCgu4A7Q9gVs/N3xGYtw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=dUlGEzUZ/8pcn5DIrrfh/Ro9dUooidLKROTwktFSdTcE77hFgZwgWjvzU9AoKEG7ri/YXCyEphkwQyv/2zYJ9Y0YCUT5GjXrNUESS92fxGxR2rzPMOSGf38crLH+S388VMG+KQOC6bEdV1N88X98sqzJs1sUKZOgnP/5fR8qynI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=O9/gfZ4F; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O9/gfZ4F"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240412044305epoutp02b3f662277c570d55c37da07e2a458514~Fbruq6nGF2229022290epoutp02N
	for <linux-block@vger.kernel.org>; Fri, 12 Apr 2024 04:43:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240412044305epoutp02b3f662277c570d55c37da07e2a458514~Fbruq6nGF2229022290epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712896985;
	bh=/G4gt6noquL1PxYFj5zy8i2+lfh6oDP/w0pBOtXUsTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O9/gfZ4Fje8N77LWBKS/vLnYmC4BUoGMKdF/UZfrKyQNsKWg7TiT+Dm9RqJuyE3lX
	 WUyfLvIrqps6IhMomoQJXtN1IFAL1SjbEVWA+F83zB9X7T4sluEVEmKKszmezT/pOm
	 AZ/Sautipo0qdzsaWFMXxt60rdph3jbR8VfwXXdE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240412044305epcas5p1518a9deb67d53474d35d97738bd1d642~FbruUjMYQ0531305313epcas5p1Z;
	Fri, 12 Apr 2024 04:43:05 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VG3pb70Dvz4x9QB; Fri, 12 Apr
	2024 04:43:03 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	71.DE.08600.7DBB8166; Fri, 12 Apr 2024 13:43:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240411134129epcas5p3f28e625fc48b93a1f492547a6f4ff894~FPYhy0OhV0593305933epcas5p3Y;
	Thu, 11 Apr 2024 13:41:29 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240411134129epsmtrp1047549bd92014c306fbb77900db94b4f~FPYhyP6Vx1026410264epsmtrp1Q;
	Thu, 11 Apr 2024 13:41:29 +0000 (GMT)
X-AuditID: b6c32a44-6c3ff70000002198-8b-6618bbd7ca9b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DA.36.07541.988E7166; Thu, 11 Apr 2024 22:41:29 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240411134128epsmtip2fdc3bef4ceebbbbea89bb6c9eddbccea~FPYg5avu_3124331243epsmtip2n;
	Thu, 11 Apr 2024 13:41:28 +0000 (GMT)
Date: Thu, 11 Apr 2024 19:04:33 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, Daniel
	Wagner <dwagern@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests 01/11] check: factor out _run_test()
Message-ID: <20240411133433.gxtwr4l6wz3mk6gj@green245>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240411111228.2290407-2-shinichiro.kawasaki@wdc.com>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTU/f6bok0g+t7LCyuPljGZvH06iwm
	i723tC3mL3vKbrFvlqcDq8fmJfUevc3v2Dw2n672+LxJzqP9QDdTAGtUtk1GamJKapFCal5y
	fkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0GIlhbLEnFKgUEBicbGSvp1N
	UX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbGpoc/WQsW8FRcnDGV
	sYFxA1cXIyeHhICJxMa1M9i7GLk4hAR2M0qcXvuWFcL5xCgx4XgzI4TzjVFi8q87zDAtS9Y+
	ZoFI7GWU+D75HQtIQkjgGaPEldepIDaLgKrEk6bJQKM4ONgEtCVO/+cACYsImElcOfYGbB2z
	QDujxIPFl8F6hQUcJW4t/80KYvMCFb1bcpUdwhaUODnzCVgNp4CzRP+JdrC4qICMxIylX5lB
	BkkIvGSXmLhkMyvEdS4Slx4+ZoewhSVeHd8CZUtJvOxvg7LLJVZOWcEG0dzCKDHr+ixGiIS9
	ROupfrA3mQUyJM7/3wc1VFZi6ql1TBBxPone30+YIOK8EjvmwdjKEmvWL2CDsCUlrn1vhLI9
	JK6c3QwN4fOMEuun/mGewCg/C8l3s5Dsg7CtJDo/NAHZHEC2tMTyfxwQpqbE+l36CxhZVzFK
	phYU56anJpsWGOallsOjPDk/dxMjOGVquexgvDH/n94hRiYOxkOMEhzMSiK80lqiaUK8KYmV
	ValF+fFFpTmpxYcYTYGxNZFZSjQ5H5i080riDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnN
	Tk0tSC2C6WPi4JRqYIq47id0Sdsh6n7lh0fesW0P6h/t2bd7n3aFsZ1UwsKd4TpyIutWzS26
	+P2h8LGN+t/El2yS4+bycZ0WmzZR6OT3vILiaec+R231LL65+XvxWnudB/+M169deSMtteTU
	vIO553abyb8NrIjhLghZ8nSzxLY3887U8zfNdag2tVfsPxyUdFvN7lnPxhNPM9ccaCuY8UyU
	4UjebWNDAz2DS1mdFhHiMxqXVlp+dn8UFb3VhPH8vI11uv9Koy+u+qm86Vlyx+uEJXO+SRvX
	/71eMztSiCO94cuzjfb7nqjNknun6j1dTOVlAeesP2FbY8q/NPIta3zVJf5CPr8k+P2XBrP9
	xkpqRpNX6qyZprz+7C0lluKMREMt5qLiRABMZpiYIgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsWy7bCSvG7nC/E0g2nbJSyuPljGZvH06iwm
	i723tC3mL3vKbrFvlqcDq8fmJfUevc3v2Dw2n672+LxJzqP9QDdTAGsUl01Kak5mWWqRvl0C
	V8a64wtYCi5xVmyby9PA+Ie9i5GTQ0LARGLJ2scsXYxcHEICuxklji18wASRkJRY9vcIM4Qt
	LLHy33N2iKInjBKN744xgiRYBFQlnjRNZu1i5OBgE9CWOP2fAyQsImAmceXYG7B6ZoFORok9
	vTfZQBLCAo4St5b/ZgWxeYGK3i25CnaFkEC1xNU585kh4oISJ2c+YQGxmYFq5m1+yAwyn1lA
	WmL5P7D5nALOEv0n2sFaRQVkJGYs/co8gVFwFpLuWUi6ZyF0L2BkXsUomVpQnJuem2xYYJiX
	Wq5XnJhbXJqXrpecn7uJERzkWho7GO/N/6d3iJGJg/EQowQHs5IIr7SWaJoQb0piZVVqUX58
	UWlOavEhRmkOFiVxXsMZs1OEBNITS1KzU1MLUotgskwcnFINTG8WLj5454LTBSH3ujOZP8/K
	bJ3iKMc080qWqKas1yXlK877lvf+maiweetRtfW18/VTUmMzpzjdviutWCzImvrN6Yf6Y2Wf
	z6uKbmnnHK05mGN2+Djzk3JWh53nO+60vdtub/szvaDNkt16ve0aN26+v+sEa2ovX7RZ1KTl
	mJK9yGWPs2zthvwD05S//0gTmLpFoqDbVt/x1XfDTTn8W9fxXc8pONum1nOtqCx3Vi/TT303
	o7vPJ9YzKnnLHIrO2R4a8nFXXVXZlxUeGy39re6c3mjIwTyx2j5uymINYVPedy6+wbW28Tqc
	jc52T1Rmsid9vepqn/SrfcM7FvXeCQ+fzT+6R6I2TP1eJWeyEktxRqKhFnNRcSIARJ3EB+EC
	AAA=
X-CMS-MailID: 20240411134129epcas5p3f28e625fc48b93a1f492547a6f4ff894
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_7665a_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240411134129epcas5p3f28e625fc48b93a1f492547a6f4ff894
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
	<20240411111228.2290407-2-shinichiro.kawasaki@wdc.com>
	<CGME20240411134129epcas5p3f28e625fc48b93a1f492547a6f4ff894@epcas5p3.samsung.com>

------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_7665a_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 11/04/24 08:12PM, Shin'ichiro Kawasaki wrote:
>The function _run_test() is rather complex and has deep nests. Before
>modifying it for repeated test case runs, simplify it. Factor out some
>part of the function to the new functions _check_and_call_test() and
>_check_and_call_test_device().
>
>Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>---
> check | 90 +++++++++++++++++++++++++++++++++++------------------------
> 1 file changed, 53 insertions(+), 37 deletions(-)
>
>diff --git a/check b/check
>index 55871b0..b1f5212 100755
>--- a/check
>+++ b/check
>@@ -463,6 +463,56 @@ _unload_modules() {
> 	unset MODULES_TO_UNLOAD
> }
>
>+_check_and_call_test() {

ret should be declared ret as local ?

>+	if declare -fF requires >/dev/null; then
>+		requires
>+	fi
>+
>+	RESULTS_DIR="$OUTPUT/nodev"
>+	_call_test test
>+	ret=$?
>+	if (( RUN_ZONED_TESTS && CAN_BE_ZONED )); then
>+		RESULTS_DIR="$OUTPUT/nodev_zoned"
>+		RUN_FOR_ZONED=1
>+		_call_test test
>+		ret=$(( ret || $? ))
>+	fi
>+
>+	return $ret
>+}
>+
>+_check_and_call_test_device() {
>+	local unset_skip_reason

Same here, ret should declared be local ?

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_7665a_
Content-Type: text/plain; charset="utf-8"


------vz81d6m7j.py-bGO0GPJ08-4LvSGVDQp9Yqo3MxnNZXK7Ax7=_7665a_--
