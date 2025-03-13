Received: from secgw2.intern.tuwien.ac.at (secgw2.intern.tuwien.ac.at [128.130.30.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB3226389F;
	Thu, 13 Mar 2025 10:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.130.30.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863446; cv=none; b=BnguZapFKMR0qdwMBQ1+zAegA2CU4K5KKHs2I9knF1Y5LrGhPGtRz+iM2grTAA/iaJHXvx4jhs3BA2Z9dFUuBDMkGdBofD//cp4abndgWl4N6Wlb7TcscyA7l/E1r6iwX67TXVYEySQ9V+rh4CahqRETUcmHQ5B/kdcXR7nPgsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863446; c=relaxed/simple;
	bh=MU0WvNUHRHTqe3ZvTck80HMMfWSXYPVLM93DH5nJthk=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nu6VK02bflH2xG02K4rfNMFXmeg5HXzTWAddqWzNJaT8zMYwMLQ3pPL74pXwmEW7QXROpA4hMKwd8NoGQyxtZ08RQcdPjwjYMXSfBrlT/Y6xPsv6SY6Se+zI89av0KF45TyCqh4QeWAnRhBulFgaGVxHyhINIkbKu9ng6U0MM40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tuwien.ac.at; spf=pass smtp.mailfrom=tuwien.ac.at; arc=none smtp.client-ip=128.130.30.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tuwien.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuwien.ac.at
Received: from Kiteworks (kwmta2.intern.tuwien.ac.at [128.130.30.92])
	by secgw2.intern.tuwien.ac.at (8.14.7/8.14.7) with ESMTP id 52DAq8pA001695;
	Thu, 13 Mar 2025 11:52:08 +0100
Received: from secgw2.intern.tuwien.ac.at ([128.130.30.72])
          by totemomail.intern.tuwien.ac.at (Totemo SMTP Server) with SMTP ID 159;
          Thu, 13 Mar 2025 10:52:07 +0000 (GMT)
Received: from edge19b.intern.tuwien.ac.at (edge19b.intern.tuwien.ac.at [IPv6:2001:629:1005:30::46])
	by secgw2.intern.tuwien.ac.at (8.14.7/8.14.7) with ESMTP id 52DAq63d001680
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Mar 2025 11:52:06 +0100
Received: from mbx19b.intern.tuwien.ac.at (2001:629:1005:30::82) by
 edge19b.intern.tuwien.ac.at (2001:629:1005:30::46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 11:52:06 +0100
Received: from t205-079.demo.tuwien.ac.at (128.131.205.79) by
 mbx19b.intern.tuwien.ac.at (2001:629:1005:30::82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 13 Mar 2025 11:52:06 +0100
Date: Thu, 13 Mar 2025 11:57:05 +0100
From: Thomas Haschka <thomas.haschka@tuwien.ac.at>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Thomas Haschka <thomas.haschka@tuwien.ac.at>,
        Ricky WU
	<ricky_wu@realtek.com>, Bart Van Assche <bvanassche@acm.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com"
	<James.Bottomley@hansenpartnership.com>,
        "martin.peterson@oracle.com"
	<martin.peterson@oracle.com>,
        <adrian.hunter@intel.com>
Subject: Re: mmc0: error -95 doing runtime resume
In-Reply-To: <CAPDyKFqyWFfyhkyB4ZA+uH8YanYbb2safzL_qM13vCDDyesPQA@mail.gmail.com>
Message-ID: <96117a90-d8e4-0476-8e7d-04495ea29a28@tuwien.ac.at>
References: <c2f50eac-3270-8dfa-2440-4c737c366b17@tuwien.ac.at> <8fd7f1d9-fc0d-4fa7-81be-378a3fc47d2a@acm.org> <CAPDyKFpwZt9rezBhBbe9FeUX1BycD2br6RRTttvAVS_C99=TiQ@mail.gmail.com> <4e7162dfccbe44468f6a452896110cc8@realtek.com> <aebf263c-570a-ed4b-bb37-22ab6596fbb3@tuwien.ac.at>
 <CAPDyKFqyWFfyhkyB4ZA+uH8YanYbb2safzL_qM13vCDDyesPQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1656070384-1741863437=:2772"
X-ClientProxiedBy: mbx19d.intern.tuwien.ac.at (2001:629:1005:30::84) To
 mbx19b.intern.tuwien.ac.at (2001:629:1005:30::82)

--0-1656070384-1741863437=:2772
Content-Type: text/plain; format=flowed; charset="US-ASCII"

Dear Uffe,

I built and tried the attached patch, however the problems with the sdcards
remain even if I remove MMC_CAP_AGGRESSIVE_PM;

All the best,
- Thomas

--0-1656070384-1741863437=:2772
Content-Type: text/plain; charset="US-ASCII";
	name="remove_mmc_cap_aggressive_pm.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <ca262cc7-5da1-a29e-d2c1-5553baa015e8@tuwien.ac.at>
Content-Description:
Content-Disposition: attachment;
	filename="remove_mmc_cap_aggressive_pm.patch"

ZGlmZiAnLS1jb2xvcj1hdXRvJyAtdXJOIGEvZHJpdmVycy9tbWMvaG9zdC9y
dHN4X3BjaV9zZG1tYy5jIGIvZHJpdmVycy9tbWMvaG9zdC9ydHN4X3BjaV9z
ZG1tYy5jDQotLS0gYS9kcml2ZXJzL21tYy9ob3N0L3J0c3hfcGNpX3NkbW1j
LmMJMjAyNS0wMi0yMSAxNDowMTo0Ny4wMDAwMDAwMDAgKzAxMDANCisrKyBi
L2RyaXZlcnMvbW1jL2hvc3QvcnRzeF9wY2lfc2RtbWMuYwkyMDI1LTAzLTEz
IDExOjUwOjMwLjQyNzAxNjM4MyArMDEwMA0KQEAgLTE0NTksNyArMTQ1OSw3
IEBADQogCQlNTUNfQ0FQX01NQ19ISUdIU1BFRUQgfCBNTUNfQ0FQX0JVU19X
SURUSF9URVNUIHwNCiAJCU1NQ19DQVBfVUhTX1NEUjEyIHwgTU1DX0NBUF9V
SFNfU0RSMjU7DQogCWlmIChwY3ItPnJ0ZDNfZW4pDQotCQltbWMtPmNhcHMg
PSBtbWMtPmNhcHMgfCBNTUNfQ0FQX0FHR1JFU1NJVkVfUE07DQorCQltbWMt
PmNhcHMgPSBtbWMtPmNhcHM7DQogCW1tYy0+Y2FwczIgPSBNTUNfQ0FQMl9O
T19QUkVTQ0FOX1BPV0VSVVAgfCBNTUNfQ0FQMl9GVUxMX1BXUl9DWUNMRSB8
DQogCQlNTUNfQ0FQMl9OT19TRElPOw0KIAltbWMtPm1heF9jdXJyZW50XzMz
MCA9IDQwMDsNCg==

--0-1656070384-1741863437=:2772--
