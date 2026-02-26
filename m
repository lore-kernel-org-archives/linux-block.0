Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2450437107C;
	Thu, 26 Feb 2026 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106694; cv=none; b=KNnWhD84NdCqMldBjpSqGS8Ke/aCAUU6/S9Ix+JOLDhClFH2k2gWR7slmCft/ftF5hwFqbrVRdeFGT3BlU5gYhYxdk7psZZE0/pAHNATLg6TkYN8NINp8yOXc3YvuAs0FnGlCZBngIEXzaYOwFsBNcPIWz3Ae9N/K4O3PFwyMAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106694; c=relaxed/simple;
	bh=vYFQ1LyhURWDzSYsTxqDdFOoUJm2jxgun+f7SEdZwaM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZyF6eAtx/CK+uP/gi3HDxZQEwDlj5A4QCTdyidrIeRkkg0REcUEee7DxWPmrDT1Dx7mXB/CzWZk+cFRuZCu1UFz7LzGcOPVJkcmoJMMonX7MligGahG5xtv/YN/Rkui+8n7LTrDg5Qrxvu5tKIcbg2ak8yE8DnK1msTABGMsRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4fM8q70TXNzYl21X;
	Thu, 26 Feb 2026 19:48:19 +0800 (CST)
Received: from a004.hihonor.com (10.68.27.131) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Thu, 26 Feb
 2026 19:51:30 +0800
Received: from a008.hihonor.com (10.68.30.56) by a004.hihonor.com
 (10.68.27.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Thu, 26 Feb
 2026 19:51:29 +0800
Received: from a008.hihonor.com ([fe80::b6bf:fc6a:207:6851]) by
 a008.hihonor.com ([fe80::b6bf:fc6a:207:6851%6]) with mapi id 15.02.2562.027;
 Thu, 26 Feb 2026 19:51:29 +0800
From: gao xu <gaoxu2@honor.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
CC: Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, "surenb@google.com" <surenb@google.com>,
	zhouxiaolong <zhouxiaolong9@honor.com>
Subject: RE: [PATCH] zram: compression algorithms name use static fields
Thread-Topic: [PATCH] zram: compression algorithms name use static fields
Thread-Index: Adym8lMkejBmbNzMQs2D5/5nPYBYaP//qjWA//9ihLA=
Date: Thu, 26 Feb 2026 11:51:29 +0000
Message-ID: <423505aa53314004b0f2ee04ed5a1266@honor.com>
References: <32d733a0719c479f85d06f6fec3cc533@honor.com>
 <p3k2ohyq7jbbhjrvi5er5rencd4ffmcauk5ts72co2exjwgfyc@r4fgfsdp5hep>
In-Reply-To: <p3k2ohyq7jbbhjrvi5er5rencd4ffmcauk5ts72co2exjwgfyc@r4fgfsdp5hep>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiANCj4gQ2FuIHlvdSBhbHNvIGNoYW5nZSB0aGUgb3JkZXIgb2YgdGhlIHdvcmRzIGluIHRoZSBz
dWJqZWN0IGxpbmUgaW4gdjI/DQo+IFBlcmhhcHMsIHRvIHNvbWV0aGluZyBsaWtlDQo+IAl6cmFt
OiB1c2Ugc3RhdGljYWxseSBhbGxvY2F0ZWQgY29tcHJlc3Npb24gYWxnb3JpdGhtcyBuYW1lcyBv
ciBzb21ldGhpbmcNCj4gYWxvbmcgdGhvc2UgbGluZXMuICBUaGUgY3VycmVudCBzdWJqZWN0IGxp
bmUgaXMgYSBiaXQgaGFyZCB0byBwYXJzZS4NCkdvdCBpdCwgSSdsbCBhZGp1c3QgdGhlIHN1Ympl
Y3QgbGluZSBpbiB2Mi4NCg==
