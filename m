Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D0A4C8F
	for <linux-block@vger.kernel.org>; Thu,  9 Nov 2023 02:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFYjm1Pg"
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625A625BC
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 18:51:27 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-da2b9211dc0so418325276.3
        for <linux-block@vger.kernel.org>; Wed, 08 Nov 2023 18:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699498286; x=1700103086; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KT6Cay0LN4XhYV9VHywOzWodCz2FB/Zo1Ej6c/2BK1Y=;
        b=hFYjm1Pg4ZY3/V5ddu4QBVpYddXZA0rjeKzOt8gx34f1hHAPXmuDLNAQegzZCc95Wn
         m671RLNAt4c6FvCpsaYy4xA7j0cATnrfCv6Y/ZaSlPjXX1S+QtU8uTsoku/SG9BUFXO6
         zpXfvZftkD9wR5c2vNFNpzo/r11zwaDKdUNLP+kT9xmYJpSwK897tdj/E58tG3o9dPAE
         cNAMrQBqjWAU3dyeaUnZW0W1XbAsODNRlmbNYwx9BIKn6k/gNtQxZj0JG5tNtURZxcob
         9W3RACdC/WzvSAW3/wpSssiwUSoIFtA2QfPoBdpORz2hchaAMx68Y8j9kxZ6XzTMAGf4
         FnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699498286; x=1700103086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KT6Cay0LN4XhYV9VHywOzWodCz2FB/Zo1Ej6c/2BK1Y=;
        b=QByLgg5zrkqFfMDsFoUw5Wml5agCsNjd+SsN46qS0dBAfMBdzWZZjIDu2ol/s6C8Qc
         dEDZ8vZ3mFD9VCXykkX5p+7bR89vO/bJpBPUul9U9nk6JcASppSky5w1spyxk9Eu6iNK
         EuwHcD6ke7gRKJsseHShIpq/3fE2Q7lN/lKaFhBDbH2f5IyNzVAoDUXd9ZhAoEV4sLBP
         O233FyNP86GBUXs0WUc4M1V1I9q1O9xTypGDp/vfrD4lYAP9Fm7B4pHn92qZJUt7Pe2k
         XK0ubkzq0Doa5ISTNqeNSYinfvy8q9HxPFJfTIBUeBKrkOsU8edyzTbNP3BIFQ8GjNFJ
         88/w==
X-Gm-Message-State: AOJu0YxiNAVCC9RSUOFCjuRxIsCdb5Pao3m1UFR1dmC+bg1cNELiNWQI
	lzO4cvRcLiPC1Za9q14TjVKq8xt3ehbWh4Z2vrf1xyqaEw/V7g==
X-Google-Smtp-Source: AGHT+IE82npBKqpXJrvHmrDgaJNXHDyEMD0g/gJo1Bg52xnmaNLl1nQrXnth061WoRaOv+h+uTR3HeFs6IAxWiuv+qo=
X-Received: by 2002:a25:b10:0:b0:d9a:ba4b:44ab with SMTP id
 16-20020a250b10000000b00d9aba4b44abmr3524597ybl.61.1699498286347; Wed, 08 Nov
 2023 18:51:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACoNggz0HC9pr5Q7jPWPWQoCvNhKmaj=qEifwZbzzCe8pNSEzA@mail.gmail.com>
 <CAEzrpqf5f4VwQWE_TZrwh-6LCNO+NXa53jRwMXaq9TBipidBuw@mail.gmail.com>
 <CACoNggx7ibJU6xWMn817vgi-HphwoHO1yxzBgiK9mAo9mh58nQ@mail.gmail.com>
 <CAEzrpqcUy3Ptrqz1p94NaLJWwte2BjF0OWX1Dy4os9mU=Jdz8Q@mail.gmail.com>
 <1ac905d4-d7d3-47aa-a289-580f5e2d9491@kernel.dk> <CACoNggza4F-2soCcLV+u7wmsUuKQubcNjDg4jhgKjQms_Ne10w@mail.gmail.com>
 <9870c433-d7d8-439c-95a4-f73ecfd5c47d@kernel.dk>
In-Reply-To: <9870c433-d7d8-439c-95a4-f73ecfd5c47d@kernel.dk>
From: Hyeonjun Ahn <guswns0863@gmail.com>
Date: Thu, 9 Nov 2023 11:51:13 +0900
Message-ID: <CACoNggxJiTfTd3BCNbQfySbW=D4jmCPe832cZO1XLhc0=r9C9w@mail.gmail.com>
Subject: Re: Out of Memory in nbd_add_socket
To: Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>, syzkaller@googlegroups.com, 
	linux-block@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000a78bec0609af473a"

--000000000000a78bec0609af473a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From dcca9cecaa77cf362e694031de080540f55d6daf Mon Sep 17 00:00:00 2001
From: Hyeonjun Ahn <guswns0863@gmail.com>
Date: Thu, 9 Nov 2023 11:41:02 +0900
Subject: [PATCH] nbd: limit the number of connections per config

Add max_connections to prevent out-of-memory in nbd_add_socket.

Signed-off-by: Hyeonjun Ahn <guswns0863@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/nbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 800f131222fc..69f7fe0d07d6 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -162,6 +162,7 @@ static struct dentry *nbd_dbg_dir;
 static unsigned int nbds_max =3D 16;
 static int max_part =3D 16;
 static int part_shift;
+static unsigned long max_connections =3D PAGE_SIZE / sizeof(struct nbd_soc=
k *);

 static int nbd_dev_dbg_init(struct nbd_device *nbd);
 static void nbd_dev_dbg_close(struct nbd_device *nbd);
@@ -1117,6 +1118,13 @@ static int nbd_add_socket(struct nbd_device
*nbd, unsigned long arg,
        /* Arg will be cast to int, check it to avoid overflow */
        if (arg > INT_MAX)
                return -EINVAL;
+
+       if (config->num_connections >=3D max_connections) {
+               dev_err(disk_to_dev(nbd->disk),
+                       "Number of socket connections exceeded limit.\n");
+               return -ENOMEM;
+       }
+
        sock =3D nbd_get_socket(nbd, arg, &err);
        if (!sock)
                return err;
--=20
2.34.1


2023=EB=85=84 11=EC=9B=94 9=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 12:34, =
Jens Axboe <axboe@kernel.dk>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 11/7/23 9:30 PM, Hyeonjun Ahn wrote:
> > Thanks for your reviews.
> > Below is the modified patch.
>
> Please send it with a CC to linux-block, as that is the proper list.
> You'll need to ensure it's just plain text, looks like it's html right
> now.
>
> And also add a proper commit message.
>
> --
> Jens Axboe
>

--000000000000a78bec0609af473a
Content-Type: application/octet-stream; 
	name="0001-nbd-limit-the-number-of-connections-per-config.patch"
Content-Disposition: attachment; 
	filename="0001-nbd-limit-the-number-of-connections-per-config.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_loql7n900>
X-Attachment-Id: f_loql7n900

RnJvbSBkY2NhOWNlY2FhNzdjZjM2MmU2OTQwMzFkZTA4MDU0MGY1NWQ2ZGFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBIeWVvbmp1biBBaG4gPGd1c3duczA4NjNAZ21haWwuY29tPgpE
YXRlOiBUaHUsIDkgTm92IDIwMjMgMTE6NDE6MDIgKzA5MDAKU3ViamVjdDogW1BBVENIXSBuYmQ6
IGxpbWl0IHRoZSBudW1iZXIgb2YgY29ubmVjdGlvbnMgcGVyIGNvbmZpZwoKQWRkIG1heF9jb25u
ZWN0aW9ucyB0byBwcmV2ZW50IG91dC1vZi1tZW1vcnkgaW4gbmJkX2FkZF9zb2NrZXQuCgpTaWdu
ZWQtb2ZmLWJ5OiBIeWVvbmp1biBBaG4gPGd1c3duczA4NjNAZ21haWwuY29tPgpSZXZpZXdlZC1i
eTogSm9zZWYgQmFjaWsgPGpvc2VmQHRveGljcGFuZGEuY29tPgpSZXZpZXdlZC1ieTogSmVucyBB
eGJvZSA8YXhib2VAa2VybmVsLmRrPgotLS0KIGRyaXZlcnMvYmxvY2svbmJkLmMgfCA4ICsrKysr
KysrCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ibG9jay9uYmQuYyBiL2RyaXZlcnMvYmxvY2svbmJkLmMKaW5kZXggODAwZjEzMTIyMmZjLi42
OWY3ZmUwZDA3ZDYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYmxvY2svbmJkLmMKKysrIGIvZHJpdmVy
cy9ibG9jay9uYmQuYwpAQCAtMTYyLDYgKzE2Miw3IEBAIHN0YXRpYyBzdHJ1Y3QgZGVudHJ5ICpu
YmRfZGJnX2RpcjsKIHN0YXRpYyB1bnNpZ25lZCBpbnQgbmJkc19tYXggPSAxNjsKIHN0YXRpYyBp
bnQgbWF4X3BhcnQgPSAxNjsKIHN0YXRpYyBpbnQgcGFydF9zaGlmdDsKK3N0YXRpYyB1bnNpZ25l
ZCBsb25nIG1heF9jb25uZWN0aW9ucyA9IFBBR0VfU0laRSAvIHNpemVvZihzdHJ1Y3QgbmJkX3Nv
Y2sgKik7CiAKIHN0YXRpYyBpbnQgbmJkX2Rldl9kYmdfaW5pdChzdHJ1Y3QgbmJkX2RldmljZSAq
bmJkKTsKIHN0YXRpYyB2b2lkIG5iZF9kZXZfZGJnX2Nsb3NlKHN0cnVjdCBuYmRfZGV2aWNlICpu
YmQpOwpAQCAtMTExNyw2ICsxMTE4LDEzIEBAIHN0YXRpYyBpbnQgbmJkX2FkZF9zb2NrZXQoc3Ry
dWN0IG5iZF9kZXZpY2UgKm5iZCwgdW5zaWduZWQgbG9uZyBhcmcsCiAJLyogQXJnIHdpbGwgYmUg
Y2FzdCB0byBpbnQsIGNoZWNrIGl0IHRvIGF2b2lkIG92ZXJmbG93ICovCiAJaWYgKGFyZyA+IElO
VF9NQVgpCiAJCXJldHVybiAtRUlOVkFMOworCisJaWYgKGNvbmZpZy0+bnVtX2Nvbm5lY3Rpb25z
ID49IG1heF9jb25uZWN0aW9ucykgeworCQlkZXZfZXJyKGRpc2tfdG9fZGV2KG5iZC0+ZGlzayks
CisJCQkiTnVtYmVyIG9mIHNvY2tldCBjb25uZWN0aW9ucyBleGNlZWRlZCBsaW1pdC5cbiIpOwor
CQlyZXR1cm4gLUVOT01FTTsKKwl9CisKIAlzb2NrID0gbmJkX2dldF9zb2NrZXQobmJkLCBhcmcs
ICZlcnIpOwogCWlmICghc29jaykKIAkJcmV0dXJuIGVycjsKLS0gCjIuMzQuMQoK
--000000000000a78bec0609af473a--
