Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E65A13E02A
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732804244; cv=none; b=G0PTlCCPxjNPFfUaH72f5RIzQT3dFNVXQiCLoaGbJlhVTF0tjciHfYlIwzgsAWJhZuxs/9pFL7uuQV9l3pEqL5Og5qMzQYIFUCT+bx9nBnZQgzlVaVTIkK5iotJdngJ0otBV9wVlr9iV6dCxjOVtV7FEw+Z6jmJKKQcB4D6a8sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732804244; c=relaxed/simple;
	bh=6ibzWyKb/TTa5uIwM07fC5om1B6A2kx9CIk8LNlpNpk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=r+de5HfoMA0wUt400eW+beLvJ95idmN1LoQFsqfHZMFwTMOh1ahIvlfrpWIQYJ/fH1ppDb5sM+Wa9/7Kw9MjTvdxYnP814uRKKVFOoeluzpRMcaSP38M7Sspx9ruAAVszd62tUHfSxhCeAtwbamnvfllLceRXheIiedD10f/qcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BasoSH+C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BasoSH+C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732804241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=CHSThdW4z76o6ECwRZj7Hi6vHVlFrCVTcqiVYGRJntM=;
	b=BasoSH+COgZwAhX8Viev7SCBw5/n7Km1gxGp00ednUC/F6Xg6ENZ+C3diRW5QxarAPcAw9
	J3Jifrj1nL1OzBKLwEBvZx0yMlyXDNbaTwG2xBeKx4mb/oSWNqVQcPPYGymtnLjy9Cqtf+
	chC2Gnstfv9F6F8f7KGO7rXNPYIyim0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-RfdmgEJ7N5-ULDwWCnsnkw-1; Thu, 28 Nov 2024 09:30:39 -0500
X-MC-Unique: RfdmgEJ7N5-ULDwWCnsnkw-1
X-Mimecast-MFC-AGG-ID: RfdmgEJ7N5-ULDwWCnsnkw
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-aa51a52a5a5so46326466b.2
        for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 06:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732804238; x=1733409038;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CHSThdW4z76o6ECwRZj7Hi6vHVlFrCVTcqiVYGRJntM=;
        b=ropiitT+Vn+QVbESiUsY+EuvF6LRO0QwYm/obGVDpBMTrQKqCHw41u4Zhwg775eF4E
         6fz2/Qu9gAygluCML8gfWliIAZo1ylUcfyIR5CjDWdtjjWFXJOnmQOI8icV1Zw/yLPLi
         7ahPkjKqOYIKOCNyJtwjB/8KIv8J0bVTuOG8Wb4DshQp8xw7XKD2yxEU6OuW4LZ/Mpfs
         3xHNGo5tYtMRQifJ38YPLmbE4i5JXFxRIzR35ZjvQYgNWYi+SceseAoGYS8S4ZPF4t7z
         Zkk2t4frY426jmZAa11OyxLH+BsbwQGRB0lO3pgZHMZ3zh5n8XcnvaH5y7YbMdBWn+pV
         aygg==
X-Gm-Message-State: AOJu0YwLH/V8AfKTVwPNVJT57MXiwzzzAum5d1N20T+4IwaJeptbjJhr
	2f4accPvMrjtJZlKY+wK5QSERIm45tsHGHxZPoby6J8LT6R/nYLAM7FcXGbk7ndrs6VT/OiaOps
	ZHOFIPZjcwizD1C+H8wEwGy3BDqLfEhPn+Imky/aQGfNR+ne1LAaf95R0UFwtJf6CMKS9vUtuy0
	2XpwfjpMGtDkYTrxJPnQcSj2z/QdobxF0+xctnZhrJO9c2vf5O
X-Gm-Gg: ASbGnctRnQ0n/42Ia7Cu9qVMxsuUpUVv9P1V1EVDzUM/oxcGe0EWp7ETrGHlKo5p5N0
	dJKZebj0tikKfguJNQ6Ug+ebcsqwUKmmW
X-Received: by 2002:a17:907:cb1d:b0:aa5:2d9a:1526 with SMTP id a640c23a62f3a-aa581093848mr460844266b.61.1732804236763;
        Thu, 28 Nov 2024 06:30:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGNDLSyOYAmSZdeLSn7SQnlA/JvyrRBmt2TwrG+f6/VuKcHZxrWsB0GARsXCaMwmJN3UhZnH6wUR28pRft6DA=
X-Received: by 2002:a17:907:cb1d:b0:aa5:2d9a:1526 with SMTP id
 a640c23a62f3a-aa581093848mr460839766b.61.1732804235721; Thu, 28 Nov 2024
 06:30:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Frank Liang <xiliang@redhat.com>
Date: Thu, 28 Nov 2024 22:30:24 +0800
Message-ID: <CAAb+4C7EK51kXwTMz3MfrvK83A8ZqcpnV4Sgp1MXRrMJ7WuhoA@mail.gmail.com>
Subject: [PATCH blktests] block/35: enable io_uring if it is disabled
To: linux-block@vger.kernel.org, osandov@fb.com
Cc: Changhui Zhong <czhong@redhat.com>, Ming Lei <minlei@redhat.com>, Libing He <libhe@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000efb64a0627f9ec52"

--000000000000efb64a0627f9ec52
Content-Type: multipart/alternative; boundary="000000000000efb6480627f9ec50"

--000000000000efb6480627f9ec50
Content-Type: text/plain; charset="UTF-8"

Enable io_uring to avoid below test failure.
block/035 (shared tag set fairness)                          [failed]
    runtime    ...  0.540s
    --- tests/block/035.out 2024-09-03 04:31:30.000000000 +0000
    +++ /usr/local/blktests/results/nodev/block/035.out.bad 2024-11-25
17:30:10.726751452 +0000
    @@ -1,2 +1,2 @@
     Running block/035
    -Passed
    +Failed (fio status = 2)

Signed-off-by: Frank Liang <xiliang@redhat.com>
---
 tests/block/035 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/block/035 b/tests/block/035
index 4228dd0..f602e9a 100755
--- a/tests/block/035
+++ b/tests/block/035
@@ -55,6 +55,11 @@ test() {
  echo "Configuring null_blk failed (2/2)"
  return 1
  fi
+ # enable io_uring when it is disabled
+ local io_uring_disabled=$(cat /proc/sys/kernel/io_uring_disabled)
+ if [ $io_uring_disabled != 0 ]; then
+    echo 0 > /proc/sys/kernel/io_uring_disabled
+ fi
  local fio_output=${RESULTS_DIR}/block/fio-output-block-035.txt
  fio --rw=randwrite --ioengine=io_uring --iodepth=64 \
  --direct=1 --runtime="${runtime}" --time_based=1 \
@@ -66,6 +71,10 @@ test() {
  local fio_status=$?
  rmdir /sys/kernel/config/nullb/nullb*
  _exit_null_blk
+ # reset io_uring setting before exits test
+ if [ $io_uring_disabled != 0 ]; then
+    echo $io_uring_disabled > /proc/sys/kernel/io_uring_disabled
+ fi
  if [ $fio_status != 0 ]; then
  echo "Failed (fio status = $fio_status)"
  return
-- 
2.47.0

--000000000000efb6480627f9ec50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Enable io_uring to avoid below test failure.<br>block/035 =
(shared tag set fairness) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0[failed]<br>=C2=A0 =C2=A0 runtime =
=C2=A0 =C2=A0... =C2=A00.540s<br>=C2=A0 =C2=A0 --- tests/block/035.out	2024=
-09-03 04:31:30.000000000 +0000<br>=C2=A0 =C2=A0 +++ /usr/local/blktests/re=
sults/nodev/block/035.out.bad	2024-11-25 17:30:10.726751452 +0000<br>=C2=A0=
 =C2=A0 @@ -1,2 +1,2 @@<br>=C2=A0 =C2=A0 =C2=A0Running block/035<br>=C2=A0 =
=C2=A0 -Passed<br>=C2=A0 =C2=A0 +Failed (fio status =3D 2)<br><br>Signed-of=
f-by: Frank Liang &lt;<a href=3D"mailto:xiliang@redhat.com">xiliang@redhat.=
com</a>&gt;<br>---<br>=C2=A0tests/block/035 | 9 +++++++++<br>=C2=A01 file c=
hanged, 9 insertions(+)<br><br>diff --git a/tests/block/035 b/tests/block/0=
35<br>index 4228dd0..f602e9a 100755<br>--- a/tests/block/035<br>+++ b/tests=
/block/035<br>@@ -55,6 +55,11 @@ test() {<br>=C2=A0		echo &quot;Configuring=
 null_blk failed (2/2)&quot;<br>=C2=A0		return 1<br>=C2=A0	fi<br>+	# enable=
 io_uring when it is disabled<br>+	local io_uring_disabled=3D$(cat /proc/sy=
s/kernel/io_uring_disabled)<br>+	if [ $io_uring_disabled !=3D 0 ]; then<br>=
+	 =C2=A0 =C2=A0echo 0 &gt; /proc/sys/kernel/io_uring_disabled<br>+	fi<br>=
=C2=A0	local fio_output=3D${RESULTS_DIR}/block/fio-output-block-035.txt<br>=
=C2=A0	fio --rw=3Drandwrite --ioengine=3Dio_uring --iodepth=3D64 \<br>=C2=
=A0		--direct=3D1 --runtime=3D&quot;${runtime}&quot; --time_based=3D1 \<br>=
@@ -66,6 +71,10 @@ test() {<br>=C2=A0	local fio_status=3D$?<br>=C2=A0	rmdir=
 /sys/kernel/config/nullb/nullb*<br>=C2=A0	_exit_null_blk<br>+	# reset io_u=
ring setting before exits test<br>+	if [ $io_uring_disabled !=3D 0 ]; then<=
br>+	 =C2=A0 =C2=A0echo $io_uring_disabled &gt; /proc/sys/kernel/io_uring_d=
isabled<br>+	fi<br>=C2=A0	if [ $fio_status !=3D 0 ]; then<br>=C2=A0		echo &=
quot;Failed (fio status =3D $fio_status)&quot;<br>=C2=A0		return<br>-- <br>=
2.47.0<br></div>

--000000000000efb6480627f9ec50--
--000000000000efb64a0627f9ec52
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-block-35-enable-io_uring-if-it-is-disabled.patch"
Content-Disposition: attachment; 
	filename="0001-block-35-enable-io_uring-if-it-is-disabled.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m41euzmn0>
X-Attachment-Id: f_m41euzmn0

RnJvbSBkMmQ2NGI3ZWU0MThjNDhhYjQ3NWUxM2MyMDgxYTE0OWQwMmQ3ZGI0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGcmFuayBMaWFuZyA8eGlsaWFuZ0ByZWRoYXQuY29tPgpEYXRl
OiBUaHUsIDI4IE5vdiAyMDI0IDIyOjE5OjIwICswODAwClN1YmplY3Q6IFtQQVRDSF0gYmxvY2sv
MzU6IGVuYWJsZSBpb191cmluZyBpZiBpdCBpcyBkaXNhYmxlZAoKRW5hYmxlIGlvX3VyaW5nIHRv
IGF2b2lkIGJlbG93IHRlc3QgZmFpbHVyZS4KYmxvY2svMDM1IChzaGFyZWQgdGFnIHNldCBmYWly
bmVzcykgICAgICAgICAgICAgICAgICAgICAgICAgIFtmYWlsZWRdCiAgICBydW50aW1lICAgIC4u
LiAgMC41NDBzCiAgICAtLS0gdGVzdHMvYmxvY2svMDM1Lm91dAkyMDI0LTA5LTAzIDA0OjMxOjMw
LjAwMDAwMDAwMCArMDAwMAogICAgKysrIC91c3IvbG9jYWwvYmxrdGVzdHMvcmVzdWx0cy9ub2Rl
di9ibG9jay8wMzUub3V0LmJhZAkyMDI0LTExLTI1IDE3OjMwOjEwLjcyNjc1MTQ1MiArMDAwMAog
ICAgQEAgLTEsMiArMSwyIEBACiAgICAgUnVubmluZyBibG9jay8wMzUKICAgIC1QYXNzZWQKICAg
ICtGYWlsZWQgKGZpbyBzdGF0dXMgPSAyKQoKU2lnbmVkLW9mZi1ieTogRnJhbmsgTGlhbmcgPHhp
bGlhbmdAcmVkaGF0LmNvbT4KLS0tCiB0ZXN0cy9ibG9jay8wMzUgfCA5ICsrKysrKysrKwogMSBm
aWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL2Jsb2NrLzAz
NSBiL3Rlc3RzL2Jsb2NrLzAzNQppbmRleCA0MjI4ZGQwLi5mNjAyZTlhIDEwMDc1NQotLS0gYS90
ZXN0cy9ibG9jay8wMzUKKysrIGIvdGVzdHMvYmxvY2svMDM1CkBAIC01NSw2ICs1NSwxMSBAQCB0
ZXN0KCkgewogCQllY2hvICJDb25maWd1cmluZyBudWxsX2JsayBmYWlsZWQgKDIvMikiCiAJCXJl
dHVybiAxCiAJZmkKKwkjIGVuYWJsZSBpb191cmluZyB3aGVuIGl0IGlzIGRpc2FibGVkCisJbG9j
YWwgaW9fdXJpbmdfZGlzYWJsZWQ9JChjYXQgL3Byb2Mvc3lzL2tlcm5lbC9pb191cmluZ19kaXNh
YmxlZCkKKwlpZiBbICRpb191cmluZ19kaXNhYmxlZCAhPSAwIF07IHRoZW4KKwkgICAgZWNobyAw
ID4gL3Byb2Mvc3lzL2tlcm5lbC9pb191cmluZ19kaXNhYmxlZAorCWZpCiAJbG9jYWwgZmlvX291
dHB1dD0ke1JFU1VMVFNfRElSfS9ibG9jay9maW8tb3V0cHV0LWJsb2NrLTAzNS50eHQKIAlmaW8g
LS1ydz1yYW5kd3JpdGUgLS1pb2VuZ2luZT1pb191cmluZyAtLWlvZGVwdGg9NjQgXAogCQktLWRp
cmVjdD0xIC0tcnVudGltZT0iJHtydW50aW1lfSIgLS10aW1lX2Jhc2VkPTEgXApAQCAtNjYsNiAr
NzEsMTAgQEAgdGVzdCgpIHsKIAlsb2NhbCBmaW9fc3RhdHVzPSQ/CiAJcm1kaXIgL3N5cy9rZXJu
ZWwvY29uZmlnL251bGxiL251bGxiKgogCV9leGl0X251bGxfYmxrCisJIyByZXNldCBpb191cmlu
ZyBzZXR0aW5nIGJlZm9yZSBleGl0cyB0ZXN0CisJaWYgWyAkaW9fdXJpbmdfZGlzYWJsZWQgIT0g
MCBdOyB0aGVuCisJICAgIGVjaG8gJGlvX3VyaW5nX2Rpc2FibGVkID4gL3Byb2Mvc3lzL2tlcm5l
bC9pb191cmluZ19kaXNhYmxlZAorCWZpCiAJaWYgWyAkZmlvX3N0YXR1cyAhPSAwIF07IHRoZW4K
IAkJZWNobyAiRmFpbGVkIChmaW8gc3RhdHVzID0gJGZpb19zdGF0dXMpIgogCQlyZXR1cm4KLS0g
CjIuNDcuMAoK
--000000000000efb64a0627f9ec52--

