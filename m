Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D0F374190;
	Wed,  6 May 2026 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051838; cv=none; b=SmxRId+tERY8d+/ZzMz1U9Thdwqy1Abj10SXJwXHG2NDHHjpIlHRu7BEOofvINrWngx7tfSAPJK39l29fnvWiHJZkADGYWo/+ZUrsHeceX+5VztpPRJvDK3RRl6pVFTH41MMHSyu84tHesFifj12KBBISfcGcBvjVwDThXigJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051838; c=relaxed/simple;
	bh=mf10+02/e8r4fXWVtEDLmrASQurL+IhSfaRiJtgw/aY=;
	h=From:Subject:To:Cc:Date:Message-ID:References:MIME-Version:
	 Content-Type; b=oG5RyPA0qfFi2RR2S2ROsRkdnGlTsIg0b5JgMk5PJk18LiLDrOqF6hwTj2DHOWB3tD/xv6oPrNJrYxt9n3HEOP901R06ZykmwKnTpqSN33/hP0IZfos5vsr5kZ4PnjyDU58A84eorkSJZylkMtINPzdga8lR3me5J7BEykGiMLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 976b3598491b11f1aa26b74ffac11d73-20260506
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:84acc0af-4488-44b8-9392-1f6a10a426ab,IP:0,U
	RL:0,TC:2,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-23
X-CID-META: VersionHash:e7bac3a,CLOUDID:f7b4701ae45353c383e412349ffcdcb5,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|83|102|898,TC:0,Content:0|14|51,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: 7F9C56BC2E66A3A051AEB346915E90AA
X-UUID: 976b3598491b11f1aa26b74ffac11d73-20260506
Received: from node2 [(10.44.16.64)] by mailgw.kylinos.cn
	(envelope-from <yanlonglong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 879864963; Wed, 06 May 2026 15:17:07 +0800
Received: from node2 (localhost [127.0.0.1])
	by node2 (NSMail) with SMTP id C0A1E6C035797;
	Wed,  6 May 2026 15:17:07 +0800 (CST)
Received: by node2 (NSMail, from userid 10001)
	id AC5276C035797; Wed,  6 May 2026 15:17:07 +0800 (CST)
From: =?UTF-8?B?5pmP6b6Z6b6Z?= <yanlonglong@kylinos.cn>
Subject: =?UTF-8?B?5Zue5aSNOiBSZTogW1BBVENIXSBibG9jazogYmljIG1heWJlIG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZQ==?=
To: =?UTF-8?B?eXVrdWFp?= <yukuai@fnnas.com>,
	=?UTF-8?B?SmVucyBBeGJvZQ==?= <axboe@kernel.dk>
Cc: =?UTF-8?B?bGludXgtYmxvY2s=?= <linux-block@vger.kernel.org>,
	=?UTF-8?B?bGludXgta2VybmVs?= <linux-kernel@vger.kernel.org>
Date: Wed, 06 May 2026 15:17:07 +0800
X-Mailer: NSMAIL 8.2
Message-ID: <4swq6d28p9q7-4swvhrytevsw@nsmail8.2--kylin--1>
References: db3d516f-6ad2-469a-9bd8-1a9b61eb12a0@kernel.dk
X-Israising: 0
X-Seclevel-1: 0
X-Seclevel: 0
X-Delaysendtime: Wed, 06 May 2026 15:17:07 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=nsmail-4wn2xbix8ps2-4wn6tout8arn
X-ns-mid: webmail-69faeaf3-4udnt5d8
X-ope-from: <yanlonglong@kylinos.cn>
X-receipt: 0

This message is in MIME format.

--nsmail-4wn2xbix8ps2-4wn6tout8arn
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6TWljcm9zb2Z0IFlhSGVpO2ZvbnQt
c2l6ZToxNHB4O2NvbG9yOiMwMDAwMDA7IiBjbGFzcz0ibF9ub2RlX2hhc19j
b2xvciI+PHA+b2vvvIwgVGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrJm5i
c3A7PC9wPgo8cD4mbmJzcDs8L3A+CjxkaXYgaWQ9InNpZ25hdHVyZVRvcCI+
PC9kaXY+CjxkaXYgaWQ9ImNzMmNfcmUiIHN0eWxlPSJtYXJnaW4tbGVmdDog
MC41ZW07IHBhZGRpbmctbGVmdDogMC41ZW07IGJvcmRlci1sZWZ0OiAxcHgg
c29saWQgI2NhY2FjYTsgLXdlYmtpdC11c2VyLW1vZGlmeTogcmVhZC1vbmx5
OyAtbW96LXVzZXItbW9kaWZ5OiByZWFkLW9ubHk7IC1tcy11c2VyLW1vZGlm
eTogcmVhZC1vbmx5OyAtby11c2VyLW1vZGlmeTogcmVhZC1vbmx5OyI+PGJy
Pjxicj48YnI+CjxkaXYgc3R5bGU9ImJhY2tncm91bmQtY29sb3I6ICNmOGY4
Zjg7IHBhZGRpbmc6IDhweCAxMHB4OyBmb250LWZhbWlseTogTWljcm9zb2Z0
IFlhSGVpOyBmb250LXNpemU6IDE0cHg7IGNvbG9yOiAjMDAwOyI+PHN0cm9u
Zz7kuLsmbmJzcDsmbmJzcDsmbmJzcDvpopjvvJo8L3N0cm9uZz48c3BhbiBp
ZD0iY3MyY19zdWJqZWN0Ij5SZTogW1BBVENIXSBibG9jazogYmljIG1heWJl
IG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZTwvc3Bhbj4gPGJyPjxzdHJvbmc+
5pelJm5ic3A7Jm5ic3A7Jm5ic3A75pyf77yaPC9zdHJvbmc+PHNwYW4gaWQ9
ImNzMmNfZGF0ZSI+MjAyNuW5tDA15pyINuaXpTE1OjA5PC9zcGFuPiA8YnI+
PHN0cm9uZz7lj5Hku7bkurrvvJo8L3N0cm9uZz48c3BhbiBpZD0iY3MyY19m
cm9tIj5KZW5zIEF4Ym9lPC9zcGFuPiA8YnI+PHN0cm9uZz7mlLbku7bkurrv
vJo8L3N0cm9uZz48c3BhbiBpZD0iY3MyY190byIgc3R5bGU9IndvcmQtYnJl
YWs6IGJyZWFrLWFsbDsiPnl1a3VhaSxKZW5zIEF4Ym9lPC9zcGFuPiA8YnI+
PHN0cm9uZz7mioTpgIHkurrvvJo8L3N0cm9uZz48c3BhbiBpZD0iY3MyY190
byIgc3R5bGU9IndvcmQtYnJlYWs6IGJyZWFrLWFsbDsiPmxpbnV4LWJsb2Nr
LGxpbnV4LWtlcm5lbDwvc3Bhbj48L2Rpdj4KPGJyPgo8ZGl2IGlkPSJjczJj
X2NvbnRlbnQiPk9uIDUvNS8yNiAxMTo1NiBQTSwgeWFubG9uZ2xvbmcgd3Jv
dGU6ICZndDsgU2lnbmVkLW9mZi1ieTogeWFubG9uZ2xvbmcgJmx0O3lhbmxv
bmdsb25nQGt5bGlub3MuY24mZ3Q7IFlvdXIgc3ViamVjdCBsaW5lIGlzIGlu
Y29tcGxldGUsIGFuZCB5b3VyIGNvbW1pdCBtZXNzYWdlIGlzIGV2ZW4gbW9y
ZSBpbmNvbXBsZXRlLiAmZ3Q7IGRpZmYgLS1naXQgYS9ibG9jay9iZnEtaW9z
Y2hlZC5jIGIvYmxvY2svYmZxLWlvc2NoZWQuYyAmZ3Q7IGluZGV4IDE0MWM2
MDJkNWU4NS4uMjdlZjczNjA4NWIxIDEwMDY0NCAmZ3Q7IC0tLSBhL2Jsb2Nr
L2JmcS1pb3NjaGVkLmMgJmd0OyArKysgYi9ibG9jay9iZnEtaW9zY2hlZC5j
ICZndDsgQEAgLTMwMzUsOSArMzAzNSw2IEBAIGJmcV9zZXR1cF9jb29wZXJh
dG9yKHN0cnVjdCBiZnFfZGF0YSAqYmZxZCwgc3RydWN0IGJmcV9xdWV1ZSAq
YmZxcSwgJmd0OyBzdGF0aWMgdm9pZCBiZnFfYmZxcV9zYXZlX3N0YXRlKHN0
cnVjdCBiZnFfcXVldWUgKmJmcXEpICZndDsgeyAmZ3Q7IHN0cnVjdCBiZnFf
aW9fY3EgKmJpYyA9IGJmcXEtJmd0O2JpYzsgJmd0OyAtIHVuc2lnbmVkIGlu
dCBhX2lkeCA9IGJmcXEtJmd0O2FjdHVhdG9yX2lkeDsgJmd0OyAtIHN0cnVj
dCBiZnFfaW9jcV9iZnFxX2RhdGEgKmJmcXFfZGF0YSA9ICZhbXA7YmljLSZn
dDtiZnFxX2RhdGFbYV9pZHhdOyAmZ3Q7IC0gJmd0OyAvKiAmZ3Q7ICogSWYg
IWJmcXEtJmd0O2JpYywgdGhlIHF1ZXVlIGlzIGFscmVhZHkgc2hhcmVkIG9y
IGl0cyByZXF1ZXN0cyAmZ3Q7ICogaGF2ZSBhbHJlYWR5IGJlZW4gcmVkaXJl
Y3RlZCB0byBhIHNoYXJlZCBxdWV1ZTsgYm90aCBpZGxlIHdpbmRvdyAmZ3Q7
IEBAIC0zMDQ2LDYgKzMwNDMsOSBAQCBzdGF0aWMgdm9pZCBiZnFfYmZxcV9z
YXZlX3N0YXRlKHN0cnVjdCBiZnFfcXVldWUgKmJmcXEpICZndDsgaWYgKCFi
aWMpICZndDsgcmV0dXJuOyAmZ3Q7ICZndDsgKyB1bnNpZ25lZCBpbnQgYV9p
ZHggPSBiZnFxLSZndDthY3R1YXRvcl9pZHg7ICZndDsgKyBzdHJ1Y3QgYmZx
X2lvY3FfYmZxcV9kYXRhICpiZnFxX2RhdGEgPSAmYW1wO2JpYy0mZ3Q7YmZx
cV9kYXRhW2FfaWR4XTsgJmd0OyArICZndDsgYmZxcV9kYXRhLSZndDtzYXZl
ZF9sYXN0X3NlcnZfdGltZV9ucyA9IGJmcXEtJmd0O2xhc3Rfc2Vydl90aW1l
X25zOyAmZ3Q7IGJmcXFfZGF0YS0mZ3Q7c2F2ZWRfaW5qZWN0X2xpbWl0ID0g
YmZxcS0mZ3Q7aW5qZWN0X2xpbWl0OyAmZ3Q7IGJmcXFfZGF0YS0mZ3Q7c2F2
ZWRfZGVjcmVhc2VfdGltZV9qaWYgPSBiZnFxLSZndDtkZWNyZWFzZV90aW1l
X2ppZjsgRWhtIG5vLCB2YXJpYWJsZSBkZWNsYXJhdGlvbnMgZ28gYXQgdGhl
IHRvcC4gUGxlYXNlIHRyeSBhZ2FpbiwgY29ycmVjdGluZyB0aGUgdGl0bGUv
c3ViamVjdCBhbmQgQUNUVUFMTFkgd3JpdGUgYSBjb21taXQgbWVzc2FnZS4g
U2VlOiBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVz
LnJzdCAtLSBKZW5zIEF4Ym9lICZsdDsveWFubG9uZ2xvbmdAa3lsaW5vcy5j
biZndDs8L2Rpdj4KPC9kaXY+CjxwPiZuYnNwOzwvcD4KPHA+Jm5ic3A7PC9w
Pgo8ZGl2IGlkPSJzaWduYXR1cmVCb20iPgo8ZGl2Pgo8cD4mbmJzcDs8L3A+
Cjxicj4KPHAgc3R5bGU9ImNvbG9yOiAjMDAwOyBmb250LXNpemU6IDE2cHg7
Ij4tLS08L3A+CjxkaXYgaWQ9ImNzMmNfbWFpbF9zaWdhdHVyZSIgc3R5bGU9
ImNvbG9yOiAjMDAwOyBmb250LXNpemU6IDE2cHg7IGZvbnQtZmFtaWx5OiBN
aWNyb3NvZnQgWWFIZWk7Ij48L2Rpdj4KPHA+Jm5ic3A7PC9wPgo8L2Rpdj4K
PC9kaXY+PC9kaXY+

--nsmail-4wn2xbix8ps2-4wn6tout8arn--
