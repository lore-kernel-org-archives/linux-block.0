Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEDC15278E;
	Thu, 27 Feb 2025 03:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740626462; cv=none; b=CCAzb/SeJN0LTyZVNINkUp16nnqj7UPVXnZxeRnh4B1SoxH1g5T+1DkZGt7sq+9lmgEfh0OBqe8n2X+Wc1veUrJPvPtgW08iUX5Bc6GCYD0IAFb4mv5Uj+FJtneactkYNNFP7Enw4LFFO3I8Wj1MYmEe9tE49n7cAe/rmEpN/rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740626462; c=relaxed/simple;
	bh=7ekryrg0JkQnPhfhXHgplTQCEGv6EXtERN+54e6F2GA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vAvwrc/dxcrRKjpYK0pUsZU0YiLC6umKHM3GKvLK4nDwHAkRab2z9DkZ4vh9SEiuKk47lb9f+jsEJxS9tztNi1afGEN0lXo6SjpRauLv+cRwtu85jWLBB0Uf5j0EvSxrTm2jnU+3eMC+Zka3ZTOuFGDx/HcuOgyOTfZZ+Mi+Wmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Je6MaUdS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Je6MaUdS"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51R3JpyhE1075058, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1740626392; bh=7ekryrg0JkQnPhfhXHgplTQCEGv6EXtERN+54e6F2GA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Je6MaUdS08TqYxJa4Zapl7TGgIexaDOxCNee76uq4biGzSUtX/1S5GuW6wUJ93y37
	 Mhsc39PEQlzYWP+BV/VQgQ21E9LrTvhhmVI+6MyTIBkiAaSJKI6U6v/rPTu6roxLkB
	 IyhLzmjNm38wUkv/BV7uuiIdXCxJMN7wRw7XitYjhKuuXozz+AEguYc2sNN1G+1Xg6
	 3TlZsLBGSJHgmRX/NRD1ruSFwqVZFvR+oGL/pOQN6dDLn85axexwTPBNsQbHr8de8b
	 UsWqupskcB7LuDn1n1VwzlCJ0AwIDZDzqhWQByZ7J94iHkQ7yP6hZrYVC/dkXYD6Z0
	 hJRJ/HwQovp9Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51R3JpyhE1075058
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 11:19:52 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Feb 2025 11:19:52 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 27 Feb 2025 11:19:51 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547]) by
 RTEXMBS01.realtek.com.tw ([fe80::f5bd:6ac9:46d:9547%5]) with mapi id
 15.01.2507.035; Thu, 27 Feb 2025 11:19:51 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Thomas Haschka
	<thomas.haschka@tuwien.ac.at>,
        Bart Van Assche <bvanassche@acm.org>
CC: "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com"
	<James.Bottomley@hansenpartnership.com>,
        "martin.peterson@oracle.com"
	<martin.peterson@oracle.com>
Subject: RE: mmc0: error -95 doing runtime resume
Thread-Topic: mmc0: error -95 doing runtime resume
Thread-Index: AQHbiEvKs6LTi7Jk9ku8Dmbfc5C+U7NaeMRw
Date: Thu, 27 Feb 2025 03:19:51 +0000
Message-ID: <4e7162dfccbe44468f6a452896110cc8@realtek.com>
References: <c2f50eac-3270-8dfa-2440-4c737c366b17@tuwien.ac.at>
 <8fd7f1d9-fc0d-4fa7-81be-378a3fc47d2a@acm.org>
 <CAPDyKFpwZt9rezBhBbe9FeUX1BycD2br6RRTttvAVS_C99=TiQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpwZt9rezBhBbe9FeUX1BycD2br6RRTttvAVS_C99=TiQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiArIFJpY2t5DQo+IA0KPiBPbiBGcmksIDIxIEZlYiAyMDI1IGF0IDE4OjIwLCBCYXJ0IFZhbiBB
c3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+IE9uIDIvMjEv
MjUgNzo0MSBBTSwgVGhvbWFzIEhhc2Noa2Egd3JvdGU6DQo+ID4gPiBCdWcgRml4OiBibG9jazog
SW1wcm92ZSBzdGFiaWxpdHkgb2YgU0QgY2FyZHMgaW4gTWljcm9zb2Z0IFN1cmZhY2UgR08gMiBh
bmQNCj4gPiA+ICAgICAgICAgICAgICAgcG9zc2libHkgb3RoZXIgZGV2aWNlcy4NCj4gPiA+DQo+
ID4gPg0KPiA+ID4gVGhlIGNvbW1pdCA2NWE1NThmNjZjMzA4DQo+ID4gPiAgICAgIGJsb2NrOiBJ
bXByb3ZlIHBlcmZvcm1hbmNlIGZvciBCTEtfTVFfRl9CTE9DS0lORyBkcml2ZXJzDQo+ID4gPg0K
PiA+ID4gYmFzaWNhbGx5IG1hZGUgdGhlIHVzZSBvZiBTRCBjYXJkcyBpbiBteSBNaWNyb3NvZnQg
U3VyZmFjZSBHTyAyDQo+IGltcG9zc2libGUuDQo+ID4gPiBUaGUgY2FyZHMgZG8gc3RvcCBmdW5j
dGlvbmluZyBhZnRlciBhYm91dCAxNSBtaW51dGVzLiBNb3N0bHkgYXQgaW8NCj4gPiA+IGludGVu
c2l2ZSB0YXNrcy4NCj4gPiA+DQo+ID4gPiBBcyBvdXRsaW5lZCBpbiBodHRwczovL2J1Z3ppbGxh
Lmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxODgyMQ0KPiA+ID4gaSBiaXNlY3RlZCB0aGUg
cHJvYmxlbSB0aGF0IHlpZWxkZWQgYW4gdW5zdGFibGUgb3BlcmF0aW9uIG9mIHRoZQ0KPiA+ID4g
Y2FyZHJlYWRlciBvbiBteSBTdXJmYWNlIEdPIDIuDQo+ID4gPiBJIHN1Y2Nlc3NmdWxseSByZXZl
cnNlZCB0aGUgY29tbWl0IDY1YTU1OGY2NmMzMDggaW4gNi4xMi4xNiB1c2luZw0KPiA+ID4gdGhl
IGF0dGFjaGVkIHBhdGNoLiBBcyBJIHN1cHBvc2UgdGhlIGJ1ZyBpbnRyb2R1Y2VkIHdpdGggdGhp
cyBjb21taXQNCj4gPiA+IG1pZ2h0IGhpdCBvdGhlciB1c2VycyBvZiBzZC1jYXJkcyBpbiBzaW1p
bGFyIGhhcmR3YXJlIEkgc3VnZ2VzdCB0aGlzDQo+ID4gPiBjb21taXQgc2hhbGwgYmUgcmV2ZXJz
ZWQsIGV2ZW4gaWYgdGhlIGltcHJvdmVkIHBlcmZvcm1hbmNlIG1pZ2h0IGJlDQo+IGdvbmUuDQo+
ID4NCj4gPiBUaGFuayB5b3UgZm9yIGhhdmluZyBiaXNlY3RlZCB0aGlzIGlzc3VlIGFuZCBmb3Ig
aGF2aW5nIHNoYXJlZCB0aGUNCj4gPiByZXN1bHQgb2YgdGhlIGJpc2VjdGlvbiBwcm9jZXNzLiBU
aGlzIGlzIHZlcnkgdXNlZnVsIGluZm9ybWF0aW9uLg0KPiA+DQo+ID4gU2luY2UgdGhlIGNvbW1p
dCBtZW50aW9uZWQgYWJvdmUgaXMgYWJvdXQgMS41IHllYXJzIG9sZCBhbmQgaGFzIG5vdA0KPiA+
IGNhdXNlZCBhbnkgaXNzdWVzIGZvciBhbnlvbmUgd2hvIGlzIG5vdCB1c2luZyBhbiBTRCBjYXJk
IHJlYWRlciwgdGhhdA0KPiA+IGNvbW1pdCBpcyBwcm9iYWJseSBub3QgdGhlIHJvb3QgY2F1c2Ug
b2YgdGhlIHJlcG9ydGVkIGJlaGF2aW9yLiBBcmUgU0QNCj4gPiBjYXJkcyBjb250cm9sbGVkIGJ5
IHRoZSBNTUMgZHJpdmVyPyBJZiBzbywgSSB0aGluayB0aGUgbmV4dCBzdGVwIGlzIHRvDQo+ID4g
dGFrZSBhIGNsb3NlIGxvb2sgYXQgdGhlIE1NQyBkcml2ZXIuIEkgaGF2ZSBDYy1lZCB0aGUgTU1D
IGRyaXZlcg0KPiBtYWludGFpbmVyLg0KPiANCj4gVGhlcmUgd2FzIGFub3RoZXIgdGhyZWFkIFsx
XSB3aGVyZSBJIHRyaWVkIHRvIGxvb3AgaW4gUmlja3kgV3UsIGJ1dCB0aGVyZSB3YXMNCj4gbm8g
cmVzcG9uc2UuIEkgaGF2ZSBhZGRlZCBoaW0gdG8gdGhpcyB0cmVhZCB0b28uDQo+IA0KSGkgVWxm
LA0KQmVjYXVzZSBJIHdhcyB3YWl0aW5nIGZvciB0aGUgcmVzdWx0IHRoYXQgcmV2ZXJ0IDEwMWJk
OTA3YjQyNCAoIm1pc2M6IHJ0c3g6IGp1ZGdlIEFTUE0gTW9kZSB0byBzZXQgUEVUWENGRyBSZWci
KQ0KQ2FuIGZpeCB0aGlzIGlzc3VlIG9yIG5vdCwgYnV0IEkgZGlkIG5vdCBzZWUgYW55IHJlc3Bv
bnNlLi4uDQoNCkhpIFRob21hcywNClRoaXMgaXNzdWUodGhpcyBtYWlsIHRocmVhZCkgYW5kIFsx
XSBhcmUgdGhlIHNhbWUgaXNzdWU/DQpBbmQgdGhpcyBpc3N1ZSBvbmx5IGNhbiByZXByb2R1Y2Ug
b24gc3VyZmFjZSBnbyAyPw0KSWYgc28sIEkgbmVlZCB0byBmaW5kIGNvcnJlY3QgcGxhdGZvcm0g
dG8gcmVwcm9kdWNlIHRoaXMgaXNzdWUgb24gbXkgaGFuZA0KDQoNCj4gRm9yIHRoZSByZWNvcmQs
IEkgYWdyZWUsIGV2ZW4gaWYgcmV2ZXJ0aW5nIDY1YTU1OGY2NmMzMDggc29sdmVzIHRoZSBpc3N1
ZSwgaXQncw0KPiBub3QgdGhlIGNvcnJlY3QgZml4Lg0KPiANCj4gVW5sZXNzIHdlIGNhbiBnZXQg
c29tZSBoZWxwIGZyb20gUmlja3ksIHdlIGNhbiB0cnkgdG8gZHJvcCBhc3NpZ25pbmcNCj4gIk1N
Q19DQVBfQUdHUkVTU0lWRV9QTSIgaW4gcmVhbHRla19pbml0X2hvc3QoKSB0byBzZWUgaWYgdGhh
dCBzb2x2ZXMgdGhlDQo+IHByb2JsZW0uIE9yIGlmIGRlYnVnZnMgaXMgZW5hYmxlZCwgd2UgY2Fu
IGRpc2FibGUNCj4gTU1DX0NBUF9BR0dSRVNTSVZFX1BNIGZvciB0aGUgbW1jIGhvc3QgdmlhIHRo
ZSAiY2FwcyIgZGVidWdmcy1ub2RlLg0KPiANCj4gVGhvbWFzIGNhbiB5b3UgdHJ5IHRvIGRyb3Ag
TU1DX0NBUF9BR0dSRVNTSVZFX1BNIGFuZCBzZWUgaWYgdGhhdCBzb2x2ZXMNCj4gdGhlIHByb2Js
ZW0/DQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KPiANCj4gWzFdDQo+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC9DQVBEeUtGcTQtZkwzb0hlVDlwaFRoV1FKcXppY0tlQTQ0N1dCSlVi
dGMNCj4gS1BoZFoyZDFBQG1haWwuZ21haWwuY29tLw0K
