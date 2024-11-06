Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD9718FDA5
	for <linux-block@vger.kernel.org>; Wed,  6 Nov 2024 21:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730929809; cv=none; b=rw4YF/euytDR450G6R1yjKW+m9jubvb9W1q1QOf1NI42/mrNVqNLScssNHpzqKIZYfhoI7nouLCFaI2WuzF+OqbMos40chs9VuTxIkvUsRXmcVZhK5q4f4IQBkHDVeeA04A9Qivxgwcpm1b9PTi+1Qe54Da1FTJBxlWpcRmS/RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730929809; c=relaxed/simple;
	bh=LgD/+xEAtrhcaImx15TmGVZuzzSdrp2PglvL5VbK/N8=;
	h=Content-Type:Message-ID:Date:MIME-Version:From:Subject:To:Cc:
	 References:In-Reply-To; b=edPOzt6ABEx2k/ERLCur/eFp2dB3UBfaeAPZyAQH4ZkhGifUEvCPvCqiM29rDsQMBf12arOLYHVxPBPgfrI24MdQHbobTtsItiVVVtUjiXewnzEoULod1IMdnyJyX5BE69Sjvvl5F2Hei4aqKbxDwQo1IRVfsAfg5eXJWmh9ftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdMp9aZs; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdMp9aZs"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53a007743e7so220714e87.1
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2024 13:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730929805; x=1731534605; darn=vger.kernel.org;
        h=in-reply-to:content-language:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1XH3cEMZBWLYYYl/LMvCPuulKd2e8WKF2iNIl0qtIM=;
        b=LdMp9aZsrRk8UzFIRhfWTEp15Frt8CuAcUyCzGGPKbYtiMInqJb6cvA3QpopurpzZD
         4gMRcOY1eV63NCBBgCz2zLYxEwae83QUOE9p9eisx+D6CMLn8D1k5nu1FKoo2MEKnffM
         gE1Y3djUDiAc0Zp5MsnQCrABH/5ABh3yAGVyC3aPfrV2+KlNCySoMyCUh2mcAOc707zL
         /8vdssIKnjEi4zcKacOgKu91yYgJ7ZRISQg9O5YPVM7zyYFi5sUgfvsMToffpyHzk+9v
         QbMjnVt/DBRvHsZ76Na5J/RKH9f7l2QWX6qoWWqYnqGnQ3k/rcschRNmSmds8MPnECQT
         ekSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730929805; x=1731534605;
        h=in-reply-to:content-language:references:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q1XH3cEMZBWLYYYl/LMvCPuulKd2e8WKF2iNIl0qtIM=;
        b=cDcDo/BEbggwmQ+mqs/KmaDr78WTJ92yGdVrzXTvQ0QpbKmEmGYv3O46fh+Bg1gCUZ
         +uPUyZvzICriL9YUJq42WSQoqBFLp+Q4dDP1kzCv1o+qpQhWU5OGQZRscrT9uPrUSuge
         /0jSjlHMrRJOfmtPWCCrzLydlMtNT98utTjancSFjzaF/dthYYoFKEwonQ+uKbdwgfll
         /NGY76K94byywcDHSVXhBhxGV6CfkX/wDEgMsaslZ8tnV9b7KjrqWbvNOkcKvsOihBpn
         fjbd46rs3K2mz4WXyxPFZxVuc6MuNwCcjv2TWSlFNP3AXyvsTMXMOOYy4hAHhW+jEq0c
         xhsA==
X-Forwarded-Encrypted: i=1; AJvYcCUdAS35fqWnlmg76utQ/n0CLUx2etiLmiHjaXJAKtROQ08Msx2rS939Qq+H4TfzDlVV5vYFAcTl/pWUXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwN912Jal09+Cu/TQLipSC8ta87za7oNGHo9xEywa2+zg+sIFpu
	fCEfiKPH+UXbrkjy26mK8T2j8gUx4Q7DkSPgOxuS4/3SM9ND7QB6
X-Google-Smtp-Source: AGHT+IH5nezi1SJ617tiG5Nrbc+Ik4wikJz/muyhUOY7ApotrhKF8+EkaGtbq8tQjK9gnGHhFUC2Gg==
X-Received: by 2002:a05:6512:3d1d:b0:539:f1e3:ca5e with SMTP id 2adb3069b0e04-53c79e8eea3mr12143962e87.44.1730929804897;
        Wed, 06 Nov 2024 13:50:04 -0800 (PST)
Received: from ?IPV6:2001:678:a5c:1202:4fb5:f16a:579c:6dcb? (soda.int.kasm.eu. [2001:678:a5c:1202:4fb5:f16a:579c:6dcb])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcce542sm2624055e87.163.2024.11.06.13.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 13:50:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------FggPhWhD9i1AHVfd97jao3y0"
Message-ID: <16adf8b3-e7b2-40ca-881f-ecb5056c3342@gmail.com>
Date: Wed, 6 Nov 2024 22:50:01 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Klara Modin <klarasmodin@gmail.com>
Subject: Re: [PATCH 2/2] block: pre-calculate max_zone_append_sectors
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
 linux-block@vger.kernel.org
References: <20241104073955.112324-1-hch@lst.de>
 <20241104073955.112324-3-hch@lst.de> <Zyu4XuKxAoVEHKp1@kbusch-mbp>
Content-Language: en-US, sv-SE
In-Reply-To: <Zyu4XuKxAoVEHKp1@kbusch-mbp>

This is a multi-part message in MIME format.
--------------FggPhWhD9i1AHVfd97jao3y0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-06 19:41, Keith Busch wrote:
> On Mon, Nov 04, 2024 at 08:39:32AM +0100, Christoph Hellwig wrote:
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 6a15873055b9..c26cb7d3a2e5 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -636,7 +636,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>>   	if (head->ids.csi == NVME_CSI_ZNS)
>>   		lim.features |= BLK_FEAT_ZONED;
>>   	else
>> -		lim.max_zone_append_sectors = 0;
>> +		lim.max_hw_zone_append_sectors = 0;
> 
> I think you need to continue clearing max_zone_append_sectors here. The
> initial stack limits sets max_zone_append_sectors to UINT_MAX, and
> blk_validate_zoned_limits() wants it to be zero.
> 

This appears to be the case. I hit this on a 32-bit x86 machine. 
Clearing max_zone_append_sectors here as well resolves the issue for me.

Regards,
Klara Modin
--------------FggPhWhD9i1AHVfd97jao3y0
Content-Type: text/plain; charset=UTF-8; name="nvme-ns-scan_bug"
Content-Disposition: attachment; filename="nvme-ns-scan_bug"
Content-Transfer-Encoding: base64

V0FSTklORzogQ1BVOiAwIFBJRDogMjEgYXQgYmxvY2svYmxrLXNldHRpbmdzLmM6NzUgYmxr
X3ZhbGlkYXRlX2xpbWl0cyAoYmxvY2svYmxrLXNldHRpbmdzLmM6NzUgKGRpc2NyaW1pbmF0
b3IgMSkgYmxvY2svYmxrLXNldHRpbmdzLmM6MzY2IChkaXNjcmltaW5hdG9yIDEpKQpDUFU6
IDAgVUlEOiAwIFBJRDogMjEgQ29tbToga3dvcmtlci91NDozIE5vdCB0YWludGVkIDYuMTIu
MC1yYzYtbmV4dC0yMDI0MTEwNi1wZW50aXVtLW1pZC0wMDAzMC1nZDlkY2FmZDkwZDE4ICMx
NwpXb3JrcXVldWU6IGFzeW5jIGFzeW5jX3J1bl9lbnRyeV9mbgpFSVA6IGJsa192YWxpZGF0
ZV9saW1pdHMgKGJsb2NrL2Jsay1zZXR0aW5ncy5jOjc1IChkaXNjcmltaW5hdG9yIDEpIGJs
b2NrL2Jsay1zZXR0aW5ncy5jOjM2NiAoZGlzY3JpbWluYXRvciAxKSkKQ29kZTogZTkgYTgg
ZmQgZmYgZmYgODMgYmIgOTAgMDAgMDAgMDAgMDAgNzQgMDcgMGYgMGIgZTkgOTggZmQgZmYg
ZmYgODMgN2IgNjAgMDAgNzQgMDcgMGYgMGIgZTkgOGIgZmQgZmYgZmYgMzEgYzAgODMgN2Ig
NTQgMDAgNzQgMGUgPDBmPiAwYiBlOSA3YyBmZCBmZiBmZiAwZiAwYiBlOSA3NSBmZCBmZiBm
ZiA4ZCA2NSBmNCA1YiA1ZSA1ZiA1ZCBjMwpBbGwgY29kZQo9PT09PT09PQogICAwOgllOSBh
OCBmZCBmZiBmZiAgICAgICAJam1wICAgIDB4ZmZmZmZmZmZmZmZmZmRhZAogICA1Ogk4MyBi
YiA5MCAwMCAwMCAwMCAwMCAJY21wbCAgICQweDAsMHg5MCglcmJ4KQogICBjOgk3NCAwNyAg
ICAgICAgICAgICAgICAJamUgICAgIDB4MTUKICAgZToJMGYgMGIgICAgICAgICAgICAgICAg
CXVkMgogIDEwOgllOSA5OCBmZCBmZiBmZiAgICAgICAJam1wICAgIDB4ZmZmZmZmZmZmZmZm
ZmRhZAogIDE1Ogk4MyA3YiA2MCAwMCAgICAgICAgICAJY21wbCAgICQweDAsMHg2MCglcmJ4
KQogIDE5Ogk3NCAwNyAgICAgICAgICAgICAgICAJamUgICAgIDB4MjIKICAxYjoJMGYgMGIg
ICAgICAgICAgICAgICAgCXVkMgogIDFkOgllOSA4YiBmZCBmZiBmZiAgICAgICAJam1wICAg
IDB4ZmZmZmZmZmZmZmZmZmRhZAogIDIyOgkzMSBjMCAgICAgICAgICAgICAgICAJeG9yICAg
ICVlYXgsJWVheAogIDI0Ogk4MyA3YiA1NCAwMCAgICAgICAgICAJY21wbCAgICQweDAsMHg1
NCglcmJ4KQogIDI4Ogk3NCAwZSAgICAgICAgICAgICAgICAJamUgICAgIDB4MzgKICAyYToq
CTBmIDBiICAgICAgICAgICAgICAgIAl1ZDIJCTwtLSB0cmFwcGluZyBpbnN0cnVjdGlvbgog
IDJjOgllOSA3YyBmZCBmZiBmZiAgICAgICAJam1wICAgIDB4ZmZmZmZmZmZmZmZmZmRhZAog
IDMxOgkwZiAwYiAgICAgICAgICAgICAgICAJdWQyCiAgMzM6CWU5IDc1IGZkIGZmIGZmICAg
ICAgIAlqbXAgICAgMHhmZmZmZmZmZmZmZmZmZGFkCiAgMzg6CThkIDY1IGY0ICAgICAgICAg
ICAgIAlsZWEgICAgLTB4YyglcmJwKSwlZXNwCiAgM2I6CTViICAgICAgICAgICAgICAgICAg
IAlwb3AgICAgJXJieAogIDNjOgk1ZSAgICAgICAgICAgICAgICAgICAJcG9wICAgICVyc2kK
ICAzZDoJNWYgICAgICAgICAgICAgICAgICAgCXBvcCAgICAlcmRpCiAgM2U6CTVkICAgICAg
ICAgICAgICAgICAgIAlwb3AgICAgJXJicAogIDNmOgljMyAgICAgICAgICAgICAgICAgICAJ
cmV0CgpDb2RlIHN0YXJ0aW5nIHdpdGggdGhlIGZhdWx0aW5nIGluc3RydWN0aW9uCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgMDoJMGYgMGIgICAg
ICAgICAgICAgICAgCXVkMgogICAyOgllOSA3YyBmZCBmZiBmZiAgICAgICAJam1wICAgIDB4
ZmZmZmZmZmZmZmZmZmQ4MwogICA3OgkwZiAwYiAgICAgICAgICAgICAgICAJdWQyCiAgIDk6
CWU5IDc1IGZkIGZmIGZmICAgICAgIAlqbXAgICAgMHhmZmZmZmZmZmZmZmZmZDgzCiAgIGU6
CThkIDY1IGY0ICAgICAgICAgICAgIAlsZWEgICAgLTB4YyglcmJwKSwlZXNwCiAgMTE6CTVi
ICAgICAgICAgICAgICAgICAgIAlwb3AgICAgJXJieAogIDEyOgk1ZSAgICAgICAgICAgICAg
ICAgICAJcG9wICAgICVyc2kKICAxMzoJNWYgICAgICAgICAgICAgICAgICAgCXBvcCAgICAl
cmRpCiAgMTQ6CTVkICAgICAgICAgICAgICAgICAgIAlwb3AgICAgJXJicAogIDE1OgljMyAg
ICAgICAgICAgICAgICAgICAJcmV0CkVBWDogMDAwMDAwMDAgRUJYOiBjMTFhN2QzYyBFQ1g6
IDAwMDAwMjAwIEVEWDogMDAwMDAwMDAKRVNJOiBmZmZmZmZmZiBFREk6IGZmZmZmZmZmIEVC
UDogYzExYTdjNTggRVNQOiBjMTFhN2M0MApEUzogMDA3YiBFUzogMDA3YiBGUzogMDAwMCBH
UzogMDAwMCBTUzogMDA2OCBFRkxBR1M6IDAwMDEwMjg2CkNSMDogODAwNTAwMzMgQ1IyOiBi
ZmZkOWM2YyBDUjM6IDA1NWE3MDAwIENSNDogMDAwMDAwMTAKQ2FsbCBUcmFjZToKPyBzaG93
X3JlZ3MgKGFyY2gveDg2L2tlcm5lbC9kdW1wc3RhY2suYzo0NzkgYXJjaC94ODYva2VybmVs
L2R1bXBzdGFjay5jOjQ2NSkKPyBibGtfdmFsaWRhdGVfbGltaXRzIChibG9jay9ibGstc2V0
dGluZ3MuYzo3NSAoZGlzY3JpbWluYXRvciAxKSBibG9jay9ibGstc2V0dGluZ3MuYzozNjYg
KGRpc2NyaW1pbmF0b3IgMSkpCj8gX193YXJuIChrZXJuZWwvcGFuaWMuYzo3NDgpCj8gcmVw
b3J0X2J1ZyAobGliL2J1Zy5jOjIwMSBsaWIvYnVnLmM6MjE5KQo/IF9fYmlvX2FkdmFuY2Ug
KGJsb2NrL2Jpby5jOjE0MTkpCj8gYmxrX3ZhbGlkYXRlX2xpbWl0cyAoYmxvY2svYmxrLXNl
dHRpbmdzLmM6NzUgKGRpc2NyaW1pbmF0b3IgMSkgYmxvY2svYmxrLXNldHRpbmdzLmM6MzY2
IChkaXNjcmltaW5hdG9yIDEpKQo/IGV4Y19vdmVyZmxvdyAoYXJjaC94ODYva2VybmVsL3Ry
YXBzLmM6MzAxKQo/IGhhbmRsZV9idWcgKGFyY2gveDg2L2tlcm5lbC90cmFwcy5jOjI4NSkK
PyBleGNfaW52YWxpZF9vcCAoYXJjaC94ODYva2VybmVsL3RyYXBzLmM6MzA5IChkaXNjcmlt
aW5hdG9yIDEpKQo/IGhhbmRsZV9leGNlcHRpb24gKGFyY2gveDg2L2VudHJ5L2VudHJ5XzMy
LlM6MTA1NSkKPyBleGNfb3ZlcmZsb3cgKGFyY2gveDg2L2tlcm5lbC90cmFwcy5jOjMwMSkK
PyBibGtfdmFsaWRhdGVfbGltaXRzIChibG9jay9ibGstc2V0dGluZ3MuYzo3NSAoZGlzY3Jp
bWluYXRvciAxKSBibG9jay9ibGstc2V0dGluZ3MuYzozNjYgKGRpc2NyaW1pbmF0b3IgMSkp
Cj8gZXhjX292ZXJmbG93IChhcmNoL3g4Ni9rZXJuZWwvdHJhcHMuYzozMDEpCj8gYmxrX3Zh
bGlkYXRlX2xpbWl0cyAoYmxvY2svYmxrLXNldHRpbmdzLmM6NzUgKGRpc2NyaW1pbmF0b3Ig
MSkgYmxvY2svYmxrLXNldHRpbmdzLmM6MzY2IChkaXNjcmltaW5hdG9yIDEpKQo/IF9fa21h
bGxvY19jYWNoZV9ub3Byb2YgKG1tL3NsdWIuYzo0MTA1IG1tL3NsdWIuYzo0MTUzIG1tL3Ns
dWIuYzo0MzA5KQpibGtfc2V0X2RlZmF1bHRfbGltaXRzIChibG9jay9ibGstc2V0dGluZ3Mu
YzozODMpCmJsa19hbGxvY19xdWV1ZSAoYmxvY2svYmxrLWNvcmUuYzo0MTcpCl9fYmxrX2Fs
bG9jX2Rpc2sgKGJsb2NrL2dlbmhkLmM6MTQzMSAoZGlzY3JpbWluYXRvciA0KSkKbnZtZV9t
cGF0aF9hbGxvY19kaXNrIChkcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYzo2NDEgKGRp
c2NyaW1pbmF0b3IgMSkpCm52bWVfYWxsb2NfbnMgKGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
YzozNjUwIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYzozNzUxIGRyaXZlcnMvbnZtZS9ob3N0
L2NvcmUuYzozODU3KQpudm1lX3NjYW5fbnMgKGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYzo0
MDU4KQpudm1lX3NjYW5fbnNfYXN5bmMgKGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYzo0MDg3
KQphc3luY19ydW5fZW50cnlfZm4gKGFyY2gveDg2L2luY2x1ZGUvYXNtL2lycWZsYWdzLmg6
MjYgYXJjaC94ODYvaW5jbHVkZS9hc20vaXJxZmxhZ3MuaDo4NyBhcmNoL3g4Ni9pbmNsdWRl
L2FzbS9pcnFmbGFncy5oOjEyMyBrZXJuZWwvYXN5bmMuYzoxMzYpCnByb2Nlc3Nfc2NoZWR1
bGVkX3dvcmtzIChrZXJuZWwvd29ya3F1ZXVlLmM6MzIzNSBrZXJuZWwvd29ya3F1ZXVlLmM6
MzMxMCkKd29ya2VyX3RocmVhZCAoaW5jbHVkZS9saW51eC9saXN0Lmg6MzczIChkaXNjcmlt
aW5hdG9yIDIpIGtlcm5lbC93b3JrcXVldWUuYzo5NDYgKGRpc2NyaW1pbmF0b3IgMikga2Vy
bmVsL3dvcmtxdWV1ZS5jOjMzOTIgKGRpc2NyaW1pbmF0b3IgMikpCmt0aHJlYWQgKGtlcm5l
bC9rdGhyZWFkLmM6MzkxKQo/IHJlc2N1ZXJfdGhyZWFkIChrZXJuZWwvd29ya3F1ZXVlLmM6
MzMzNykKPyBrdGhyZWFkX3BhcmsgKGtlcm5lbC9rdGhyZWFkLmM6MzQyKQpyZXRfZnJvbV9m
b3JrIChhcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jOjE1MykKPyBrdGhyZWFkX3BhcmsgKGtl
cm5lbC9rdGhyZWFkLmM6MzQyKQpyZXRfZnJvbV9mb3JrX2FzbSAoYXJjaC94ODYvZW50cnkv
ZW50cnlfMzIuUzo3MzcpCmVudHJ5X0lOVDgwXzMyIChhcmNoL3g4Ni9lbnRyeS9lbnRyeV8z
Mi5TOjk0NSkK

--------------FggPhWhD9i1AHVfd97jao3y0--
