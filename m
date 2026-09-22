Received: from mail-yx2-f7.google.com (mail-yx2-f7.google.com [74.125.224.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264DC535FCA
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 12:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079070; cv=pass; b=IIBYDL9tIWB/gD/VIh3oEhdsr42nAuXELDTZ31zsEQU51qm9G2CD0IfCySVjeq0Si9g5vuliyfdT8pn/kWLkux2A0FrNJgSgHZ05ecNcXcn9SowN/pqOh/M4MAF9yi9bhdjtQDD7SgKb1vEUR8ybf1tCGrxY+rVrdWZByM7nXMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079070; c=relaxed/simple;
	bh=UDre4lqux7Xicwi+fojVvKcL8dYa3ExtouGNXeiHI1k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=HeiScsvpmsTzRDyLugzenO2E9bLI8XLtlmTuF6wmDg2Fi1QJFOznlrYXsIvPXpE2KNJiDdHoLJmW/9G2TLUgwLKaIrdyAU4L1GOfDffLJ06PzTEW3/5AEgROE6k7KBOS1eEV5HUi7GcyUk//gxPuigCawnHk5ENJgL1HQkxyCLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSFRxe4J; arc=pass smtp.client-ip=74.125.224.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSFRxe4J"
Received: by mail-yx2-f7.google.com with SMTP id 00721157ae682-8552adbe8ebso8477337b3.1
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 05:11:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790079068; cv=none;
        d=google.com; s=arc-20260327;
        b=BehxQ9U5I0GMl6I9oZGXihNUNqRlFHOpOXDi5ru1iS3O9+NptOO5/lPmdlFxq+hs9o
         JIQ5UcHuePzEBzg9zJeD7kIxjRhYNRG9kCoJmBhmZIwQzTFQ0PpPNB3ib0Hc04P12tQJ
         FAXL39aOI33dJsAfKmaxLkJyNQlhaViB7qd2zIYtzt5gx2yFqKlZyDuRHcYV3NxkjOWt
         YUMIV4JYNb28mkFCTGikZHzNdA/bS7ordbgrgKmyLxyF6MsELOeyDKlNwo8xjhiGp4TV
         9e0bC+Pns0MCaI928CZxihENbNAI56PJA1C1yhRJzwmvAXzd7aBHNma4itqwAm7z693A
         pJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :dkim-signature;
        bh=33MOPJgpvg9zM9RDeL1oh9Q/BC1A+9nzmHtNl+8zkU4=;
        fh=CcE2iZyys1CzyZd31cCWxvgHrz/n0XDUo1SQvLO3XnU=;
        b=YdRBPHLjSx5v48OJ/FDIG71EzYP8ijhkOre70s7W6UcTcqcxiO9jX1sgtkKXd/6xSJ
         CX7yVZHBznXBqql/Kja/PgLM+u+8+Hvnf08SWERmo91E9pasgIcim3HUXM06+4Qrez8d
         qlBn5ZeulnNCjdt6CiVsZ1NKxOoTpsAfuClLCWGOAylUju/oge2uwU0Xh9eN8Ajr6uJx
         kAef11XBtKILqI7g9DsiNAJTSWC8NgbE7A10X0psJ+iLWdlt8n/N8wDQIyLLA3lrnbHq
         n0ogdDrSUIXB0a1rZbMBWzqRfiOx/Hw6IR1vnJxh7kMqmj2KzwNi0Ti+oaR15+3IEnfN
         P8MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790079068; x=1790683868; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=33MOPJgpvg9zM9RDeL1oh9Q/BC1A+9nzmHtNl+8zkU4=;
        b=fSFRxe4JNAEAx+3lWRkILhN6ZoJk8RMzMldMl5fiR4OaLDNFRKgiOPr/05shc7THOf
         mcRZ7dQ0qt99RrhFHM76hRnEjuMQctyZtKWwl+uYeO1PTUn2jl4gYUnXMVLRm8usGxUh
         gD6Cf+o8uGxQuVq4sr1GIk9+Ngs46U91N3sbwpdLCafezgNjOrP7d0yBQmk4n9Qpsym3
         npYqh7f7mNXy3SxX9SKSODqu+V0WhzM8nVmQaPM2gCHJG83ThC4E4T5dLUgLRUzsmNc4
         0Y0cxCa7BegeRKGMnm0zSKzrFrudqAJ6Np2Axw7UaP070uLpd4DyE8b7nCdgY6101t8/
         hPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790079068; x=1790683868;
        h=content-type:cc:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=33MOPJgpvg9zM9RDeL1oh9Q/BC1A+9nzmHtNl+8zkU4=;
        b=yUOztrb+SYHIOL/w1NTc79F+8l4Rz+fd6YolUjmcPvYsBloYg+NhChSQVs/1aovQ74
         jq9q6xc0tnOtJGPlRQD5Y7m5F2IsrJisea1Y8i7eJP9w4pcpZgPZv8BgPyudDlVYUkSj
         JBZtzhM8X2cvUg8U5ADTXu7w3B5Zfd7A1FqUNw8rsMODT8nAXf2+RLZSRuvU5Bhhy3cV
         H4CuB5vG5TDAFglrM+lc/RoyiCqEd1bpjYFlozbue9bsu3mYy7unFvOU9ryX0xvFdDJ+
         o8ijzufzOqmMMq6BVDsspzUv+Cy2xNqU1uvu7qAuPYtbm1rPTivSHSkK1D+GRP+0axZO
         acOw==
X-Gm-Message-State: AFuF++lDQECjcuPBb8+QeCDAwodcVLEfJgevKIUn9w7TU9iA74WqPqJ3
	+arOdrvq++tllIs0HPSZKH841RHfjjcg4sss9az18nCWF372H/UR2MB6ihXvcYXquIRM1i+fvQU
	nSKscxURIDxrUyiRmGDqYR3A6CBPsIKQ=
X-Gm-Gg: AYBFou1co9FuyUJ7RiRz7/8IblDHzeP6eUgOiiOQwHgVI0DEOIg9XCJ+NNjDeVdD04o
	mTRu6rpR91qJzrXBnf1vOnDGkYG6ZNHA5wz+bcLqSYXW44He0GjqIy4omkh0STSt2ERh/eN8iRT
	O9rvTQlrzeToFG/WKe0SGP4UZrfDm93QcYy5jUIJoVihZnJF8YxMhrhxH3nZX2zf3RSQIM702xR
	E2KafunyGIw+369T5Vj/kHwSggXBmMmos2t/Cy//uo68IkxFRRfSFXMQ+ehdZuXGUurUWSOb3IH
	O1lmkAFPN+O1q9DNaJ15s7TPKS/Yh7uZs7XSzlBF/+10ZKJEPNFHRmcm1OjKmQeuw5acjeHK+Bc
	oCjwmyXNkDPzfIWLL/G1vSrDr2xZCR0pePaSfeg==
X-Received: by 2002:a05:690c:34c9:b0:89f:a3c7:402a with SMTP id
 00721157ae682-8a254895b66mr9451467b3.15.1790079067831; Tue, 22 Sep 2026
 05:11:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: www.rokinthanp03@gmail.com
From: Rokinthan p <rokinthanp03@gmail.com>
Date: Tue, 22 Sep 2026 17:40:50 +0530
X-Gm-Features: AcwNN1WqR55AEPQHwUcgSGoSAVt3qtxdFgKe7oLMbyWc5WkpOjGsZD5Dti4AAeE
Message-ID: <CAHzb5FHOCS+mH2DbFrxUB+=a9Wh4Za2Vf-2=fR_pY3_mgX_cRw@mail.gmail.com>
Subject: [PATCH] zram: reject zero or overflowed disksize in disksize_store
To: minchan@kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+fb23651a7efbea8868ed@syzkaller.appspotmail.com
Content-Type: multipart/mixed; boundary="000000000000f57554065c114200"

--000000000000f57554065c114200
Content-Type: text/plain; charset="UTF-8"



--000000000000f57554065c114200
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-zram-reject-zero-or-overflowed-disksize-in-disksize_.patch"
Content-Disposition: attachment; 
	filename="0001-zram-reject-zero-or-overflowed-disksize-in-disksize_.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mucmtal30>
X-Attachment-Id: f_mucmtal30

RnJvbSAzZGE4OGViMDZjYWIzMWJhMzVjYzkxYmNmNjU4M2FlMTU1MDE3MjEwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb2hpbnRoYW4gPHJva2ludGhhbnAwM0BnbWFpbC5jb20+CkRh
dGU6IFR1ZSwgMjIgU2VwIDIwMjYgMTY6MjY6NTcgKzA1MzAKU3ViamVjdDogW1BBVENIXSB6cmFt
OiByZWplY3QgemVybyBvciBvdmVyZmxvd2VkIGRpc2tzaXplIGluIGRpc2tzaXplX3N0b3JlCgpX
aGVuIHVzZXJzcGFjZSB3cml0ZXMgYSB2YWx1ZSBjbG9zZSB0byBVNjRfTUFYIChzdWNoIGFzICh1
NjQpLTEpIHRvIHRoZQpzeXNmcyBhdHRyaWJ1dGUgL3N5cy9ibG9jay96cmFtPGlkPi9kaXNrc2l6
ZSwgZGlza3NpemVfc3RvcmUoKSBwYXJzZXMgaXQKd2l0aCBtZW1wYXJzZSgpIGFuZCB0aGVuIGNh
bGxzOgoKICAgIGRpc2tzaXplID0gUEFHRV9BTElHTihkaXNrc2l6ZSk7CgpCZWNhdXNlIGFkZGlu
ZyBQQUdFX1NJWkUgLSAxIHRvIHZhbHVlcyBpbiB0aGUgcmFuZ2UKW1U2NF9NQVggLSBQQUdFX1NJ
WkUgKyAyLCBVNjRfTUFYXSBjYXVzZXMgYW4gaW50ZWdlciBvdmVyZmxvdyB3cmFwcGluZwp0byAw
LCBkaXNrc2l6ZSBiZWNvbWVzIDAuIGRpc2tzaXplX3N0b3JlKCkgdGhlbiBwYXNzZXMgMCB0bwp6
cmFtX21ldGFfYWxsb2MoKSwgd2hpY2ggY29tcHV0ZXMgbnVtX3BhZ2VzID0gMCBhbmQgY2FsbHMg
dnphbGxvYygwKS4KCkluIG1tL3ZtYWxsb2MuYywgX192bWFsbG9jX25vZGVfcmFuZ2Vfbm9wcm9m
KCkgY2hlY2tzCmBpZiAoV0FSTl9PTl9PTkNFKCFzaXplKSlgIGFuZCB0cmlnZ2VycyBhIGtlcm5l
bCB3YXJuaW5nOgoKICAgIFdBUk5JTkc6IG1tL3ZtYWxsb2MuYzo0MDM4IGF0IF9fdm1hbGxvY19u
b2RlX3JhbmdlX25vcHJvZgogICAgQ2FsbCB0cmFjZToKICAgICBfX3ZtYWxsb2Nfbm9kZV9yYW5n
ZV9ub3Byb2YKICAgICB2emFsbG9jX25vcHJvZgogICAgIGRpc2tzaXplX3N0b3JlCiAgICAgZGV2
X2F0dHJfc3RvcmUKICAgICBzeXNmc19rZl93cml0ZQoKRml4IHRoaXMgYnkgY2hlY2tpbmcgaWYg
ZGlza3NpemUgd3JhcHBlZCB0byAwIGFmdGVyIFBBR0VfQUxJR04oZGlza3NpemUpCmFuZCByZXR1
cm5pbmcgLUVJTlZBTC4gQWxzbyBhZGQgYSBkZWZlbnNpdmUgY2hlY2sgaW4genJhbV9tZXRhX2Fs
bG9jKCkKdG8gcmV0dXJuIGZhbHNlIGlmIGRpc2tzaXplIGlzIDAsIGF2b2lkaW5nIHZ6YWxsb2Mo
MCkgdW5kZXIgYW55CmNpcmN1bXN0YW5jZS4KCkZpeGVzOiBjZDY3ZTEwYWM2OTkgKCJ6cmFtOiBw
cm9tb3RlIHpyYW0gZnJvbSBzdGFnaW5nIikKUmVwb3J0ZWQtYnk6IHN5emJvdCtmYjIzNjUxYTdl
ZmJlYTg4NjhlZEBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCkNsb3NlczogaHR0cHM6Ly9zeXpr
YWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPWZiMjM2NTFhN2VmYmVhODg2OGVkClNpZ25lZC1v
ZmYtYnk6IFJvaGludGhhbiA8cm9raW50aGFucDAzQGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL2Js
b2NrL3pyYW0venJhbV9kcnYuYyB8IDYgKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9jay96cmFtL3pyYW1fZHJ2LmMgYi9kcml2
ZXJzL2Jsb2NrL3pyYW0venJhbV9kcnYuYwppbmRleCA2Y2I0NGUyLi5mZGQxM2RmIDEwMDY0NAot
LS0gYS9kcml2ZXJzL2Jsb2NrL3pyYW0venJhbV9kcnYuYworKysgYi9kcml2ZXJzL2Jsb2NrL3py
YW0venJhbV9kcnYuYwpAQCAtMTk4OSw2ICsxOTg5LDkgQEAgc3RhdGljIGJvb2wgenJhbV9tZXRh
X2FsbG9jKHN0cnVjdCB6cmFtICp6cmFtLCB1NjQgZGlza3NpemUpCiB7CiAJc2l6ZV90IG51bV9w
YWdlczsKIAorCWlmICghZGlza3NpemUpCisJCXJldHVybiBmYWxzZTsKKwogCW51bV9wYWdlcyA9
IGRpc2tzaXplID4+IFBBR0VfU0hJRlQ7CiAJenJhbS0+dGFibGUgPSB2emFsbG9jKGFycmF5X3Np
emUobnVtX3BhZ2VzLCBzaXplb2YoKnpyYW0tPnRhYmxlKSkpOwogCWlmICghenJhbS0+dGFibGUp
CkBAIC0yODc4LDYgKzI4ODEsOSBAQCBzdGF0aWMgc3NpemVfdCBkaXNrc2l6ZV9zdG9yZShzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLAogCX0KIAogCWRp
c2tzaXplID0gUEFHRV9BTElHTihkaXNrc2l6ZSk7CisJaWYgKCFkaXNrc2l6ZSkKKwkJcmV0dXJu
IC1FSU5WQUw7CisKIAlpZiAoIXpyYW1fbWV0YV9hbGxvYyh6cmFtLCBkaXNrc2l6ZSkpCiAJCXJl
dHVybiAtRU5PTUVNOwogCi0tIAoyLjUzLjAKCg==
--000000000000f57554065c114200--
