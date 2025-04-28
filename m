Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3F026158D;
	Mon, 28 Apr 2025 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848126; cv=none; b=iYjyjtZBkEw8aGt2TFKQi0qS1DLQaYj0dYzDWxvvp5zzDZLKXzwZsVr1jE9mEBHFddYU7wl5SUPkrsZKvkMbhuqkH3bra38g62kNoTnrNR7FO2iTsOAQr9K24bcOwvqJ/glhTh1TySIzoUAmAiEO/GNPsHaOyX8Eohrq/YUevnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848126; c=relaxed/simple;
	bh=ve9q389xRd68/h1niFws9BhkxRrMK/paAaWtP6Lite4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZT2Mr/uFEr5RlFNHCHvQtptq/iYhoxqbKbU1F3nzw0Sf/hdiVZRL20cR6vV3l5cx1+Kew+PIiZMDAgSx9atKOhKfqlX2CTTCfpDtAywUXv2uewtWL0x0fB/CvmzLvcjNhZvoFL69s0kU6xoE+wstc4P5IPoqlauR7LvCFcNT9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SAA2VL030698;
	Mon, 28 Apr 2025 06:48:16 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 468ts3rqsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 28 Apr 2025 06:48:16 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Mon, 28 Apr 2025 06:48:15 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Mon, 28 Apr 2025 06:48:13 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <hch@infradead.org>
CC: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <ming.lei@redhat.com>,
        <syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH V2] loop: Add sanity check for read/write_iter
Date: Mon, 28 Apr 2025 21:48:12 +0800
Message-ID: <20250428134812.3225991-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aA94oQekLdgnjt67@infradead.org>
References: <aA94oQekLdgnjt67@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDExMyBTYWx0ZWRfX1bg0NRFgmpYp GEebUuHFtqhlZp0wLyGJhP/UuNQvMTGGYlc7cUuM3WWe06MiyR1Wpz3k1Li31oldKHOsDDEU4PO gFFv1WirY3tSFWOIXF7hPejEwlacW+ELALaUxTJueuJjfe+VvGFm64ndOv9Sd7aMX+Stqelx1Bg
 0zDA0BUip60bUsQ2ppznfFtOlSQSSTbYcJWamYgXtyqpDTxwDbPPdKft3IVvww2X2BjrVkqWDW7 bba4QvFZGHxHxTMPEq1CSFwibXWpQr1jQ9vq8SnPF6WtVy/h52cJqTG9ijoDHe7qdXEAhX6o6sg WlX4IbqEELs1MNOS4cc8abTLdPOIJAaMijVz8BPko8GGTmmPYM30UGTpqhjqClcaz1yyp67dC9U
 NP3acOdZRaC3qER6ii4KalTpDc6hRVWvesIOUH78BhEFZROIb8C8b95GhmQHj6gA7m3VRe9q
X-Proofpoint-GUID: uZkO32fWXUHA4Yxq_zMZw0pm0ay4-X7D
X-Proofpoint-ORIG-GUID: uZkO32fWXUHA4Yxq_zMZw0pm0ay4-X7D
X-Authority-Analysis: v=2.4 cv=YJifyQGx c=1 sm=1 tr=0 ts=680f8720 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=XR8D0OoHHMoA:10 a=q8Zuf2oMPCBVsqgiH-oA:9
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=532 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.21.0-2504070000 definitions=main-2504280113

On Mon, 28 Apr 2025 05:46:25 -0700, Christoph Hellwig wrote:
> > > and maybe add a blurb that vfs_iter_read/write had this check.
> > It makes no sence. The current issue context does not involve vfs layer
> > iter_read/write related routines.
> 
> Yes.  But explaining how a change caused a regression is good
> information for a commit log.
What changes?
The check in vfs_iter_read/write is not relevant to this case.
It is best to not write something irrelevant.
