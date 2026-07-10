Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E48C420E7A
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 12:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783686402; cv=pass; b=NOrj8HL7sRpYh0mr2kWBrx2Y0r2iFzJq8Q0nYUI/U4TZ4zl5OiHcBttIRTBbIeoJl6vnPxuxJVsE1CoDFNs+R6buz8ex9My4xk/viB/tAJDUt7kv4ZNfacjqfTpt3792e+cV/co26dfsH0526djUiSdtoG9ujkQmj/90GcIA3dI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783686402; c=relaxed/simple;
	bh=q4/BQ4KH5y3vSKgWe4o/xo7A1YY9mmS0eOWDxqB1uLw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Z+iXN5Wbt9w7XVBkFpxhOAAjz/zjTuBze2p0n5tutp4pw1QBpk+QL+aPpnjqK2FWz+mLc+tO3g9JYxYjeImQKmqzZHwit41Qwas7uqR+oPf9duwO8p7la3ykzaPUyJeVTBSSh1wDc1SRvsdtqP0m8JByWusZLcS2zHBZTrFXX1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqX9Ea6I; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqX9Ea6I"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90004d2f7b7so13226506d6.1
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 05:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783686399; cv=none;
        d=google.com; s=arc-20260327;
        b=FB+vinuvNFEx7EINM3/yYFCCJeZpWTdK9v5lBjTewdICY0Z38gggeqzgSrt8A2sMwU
         yDRFqy71hBn9kHZ/Ff4f1x7gDJ/cuTrNdKfaWcgLT7XjUZeMQpXJBHOnPMEOuFC99ACx
         Km2BIvspS7L8OTu/Qb5DmtdJeJ37lqLvfB/8RAwY39ufjwKZqsjHq2Fp0PeWIbgJCpaR
         Rfhror5QAOPpWl2StGbXj+aVMCVkrUfYW0CSGTFgs3IYoIqa8+yFYn9xPIEBzOrTRwPK
         RYNdYxmDeTTdLjFtVAJAcyR/epdeuOpDxnlG5IXa3R+qSWxRwt1qzouLoePpdXjhFs8d
         sKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=P7LqUBukt2rMNYxiApGcoalzSvkntcsDQXDi4tpWW30=;
        fh=eosDhnWcWiQc8na2k6XbyaML2Ll696MP+Nzji/sa+Nc=;
        b=G9a4M5Pw1ztPN3mwmPGW+u9GvDe4NMdhMNZXpCdbiDDN+A3Z7slzXADhnWfgJsj236
         y6HKRMD4gFE1+r72MSS9/JXBCHKwnXEQxWYSxV4O9LQ+Ay33LHMPlGwZkLJKd8mzb/Yd
         YFKCK3L6mmJhDHIQ6XXFG/qlsD8J2lUgsbCnhv/VlysOOT6jF0RHpdoXXM1ivQGDFRLp
         mo8oxCxV3VD+mniGJ0vPBDF94V1uju2kVOyJPdIppRvAbm6ThafSw0vSdN+32bpaYoHP
         cnMYnmZccbt5hDgJa2fq9iJ8BQPe8A1857/fAflGtUwG5r9JmMTzzVJ6Av6/mo0GBCOD
         QUpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783686399; x=1784291199; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P7LqUBukt2rMNYxiApGcoalzSvkntcsDQXDi4tpWW30=;
        b=MqX9Ea6I0XAmE+Dy2Ilh3SXv4RmzGZGG3Iv5dHwDzn5GBdV1DagwF6GGTOtc67p439
         fmpWSXjYDv15VXaTpUMd2HKrSBq0yjJCRkPYlPMRUBspo3QU/nqV7WVQZYSgWeePCC4B
         x/NiKIZQl15cWXWa/tYxa15pWP6TfrK746YYcOxww60/7UmBxJ3Zk6u3vCKNqCt+uTV6
         bcDlqmaF0/662N56dq6qKUetY+vacQLQpQK4eUVbN/CWfhFT4aL0UH1F+TGU4XBxE2zz
         Mp/K1csTvdd5nKhP/OZf8rAp78g+p/etxZrfVu6rGzYjrYnBL9E/xGW1v9RWnjZYSxV1
         6Rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783686399; x=1784291199;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P7LqUBukt2rMNYxiApGcoalzSvkntcsDQXDi4tpWW30=;
        b=gPl71yr24VUbp3ZcfErO4WzFrrDomg89O3AV4bxAGjHf/hkVR608K5d3A4Qvm1vXwW
         Aj7AbI+PuGvqIsjHztnnU8hB/dNbQV2vFr34SWjE9XP1QHjsNYYvqa8SfBusgg99FLyV
         OqFbo6V7mbpOcZzbQNAw2rJgBP0jPYXHsYCdKH5LBuF/U8Hgg5HUbjIGchGg1UnQitvD
         RGvFPhFbhwoItRzzSveQUjgPgqyRLu42sA2JkLhOzLUwZi/PVC6qUX0CCEuCPoy10FqH
         GgGzpYpkMlQm0exNb6Qz50lVn4L8R65p77lHB08AvC63dFFuNytAAuHxBnG7/yTDvSgS
         P/yA==
X-Gm-Message-State: AOJu0YycAPWMrNfiY9IB2hIq/nB8yBAg5Fz8SyCYl697f5bOuTY9wDHC
	eAt4Mb6536dqgxo41R8eJ+kQFaP+OQ7QAvPsxx7BZYTwpWHfsr8P+mPMkcBmF6qZ4OjWzgAPnZY
	Y4p9kjerAjg2w+F77KRw6N2ErhfbS0Cg=
X-Gm-Gg: AfdE7ckE4CuB/iu3gahxXj1+3wNgQ1QD+fqFELT8fQCQfUt3TgouR7LCbbRYLxgHc+p
	XHpwvvxbhV3HXCjBngUfopd4S7kSWUXp5XmALFEYfcn4tRuD4skzVH1cAmGTWvgWIq7DR0iE3aq
	J9jlqpYvv9wubL9zSrKGDGagtxrKj6rxW21RYXdUTlZLkFSSPiCPaptGxR51ZUedy1LXxkGASNF
	QqwcF69IdZP8i1khvgAfi4aPtOKn9kimdPotC2uDQX8kz8m+kKZoPjda/7RVgITVV9wneA=
X-Received: by 2002:a0c:f405:0:b0:8fd:6e32:2bf9 with SMTP id
 6a1803df08f44-8fec3ee152cmr119011706d6.58.1783686398554; Fri, 10 Jul 2026
 05:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Neptune <z1281552865@gmail.com>
Date: Fri, 10 Jul 2026 20:26:25 +0800
X-Gm-Features: AUfX_mw8y3IeQlYXYwrVIOk3H3rSo8TmkgFooSQ78Wlg3JjdHwdwIGi1frxoQ7w
Message-ID: <CAKTh279tH68oS4gTQd9DFqNuegvAhwZ8ck2uViR+cbeJDW9jDA@mail.gmail.com>
Subject: [RESEND][SECURITY] block: double unpin in bounced direct reads
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, security@kernel.org
Content-Type: multipart/mixed; boundary="0000000000002db5c5065640dad7"

--0000000000002db5c5065640dad7
Content-Type: text/plain; charset="UTF-8"

Resending in plain text because my first message was rejected by the
mailing list due to its MIME format. The technical content is
unchanged.

Hi Jens, Christoph,

I found a double-unpin in the block-layer read-bounce path that can be
reached by an unprivileged process through XFS direct I/O. I
reproduced it as a uid-1000 to uid-0 privilege escalation on mainline
commit 0e35b9b6ec0f. The bug was introduced by e7b8b3c5b2a6 ("block:
align down bounces bios"), which first appears in v7.1-rc4.

AI-assisted tooling was used during the source review and validation.
I independently verified the bug against the source, reproduced the
complete privilege-escalation chain, and tested the proposed fix. I am
treating the finding as public for coordination purposes, but I have
not included the reproducer or exploit in this message.

bio_iov_iter_bounce_read() stores the bounce folio in bi_io_vec[0],
while the extracted user bvecs start at bi_io_vec[1]. bi_vcnt counts
only those user bvecs. bio_iov_iter_align_down(), however, treats
bi_vcnt as the length of an array starting at slot zero and selects
the last vector with bio->bi_io_vec[bio->bi_vcnt - 1].

I create the partial extraction with three iovecs: a one-byte mapped
segment, a 512-byte mapped segment, and a 511-byte PROT_NONE segment.
The complete 1024-byte read is aligned, but pinning the third segment
fails after the first two segments have already produced 513 bytes.
This leaves the following state immediately before trimming:

    bi_size        = 513
    bi_vcnt        = 2
    len_align_mask = 511

    vec[0] = bounce folio,     len 513
    vec[1] = first user page,  len   1
    vec[2] = second user page, len 512

The one-byte remainder should be removed from vec[2], but the helper
selects vec[1]. Because that bvec is exactly one byte long, it is
removed and its page is unpinned. bi_vcnt becomes one, and read-bounce
completion subsequently walks the user array from vec[1] and unpins
the same page again. Once the partial-extraction state has been
created, the two unpins are deterministic and do not depend on a race.

The in-tree path I confirmed is xfs_file_dio_read() with
IOMAP_DIO_BOUNCE set when mapping_stable_writes() is true. The trigger
needs a non-DAX XFS file backed by an allocated extent on a device
that either provides an integrity checksum or advertises
BLK_FEAT_STABLE_WRITES. It only requires read access to that file and
an aligned O_DIRECT vectored read; raw block-device access and
capabilities are not required. In my test setup, queue/stable_writes
was zero, but the NVMe namespace exposed T10-DIF-TYPE1-CRC, which also
makes bdev_stable_writes() true.

For the privilege-escalation test, I registered the page backing the
one-byte first iovec as an io_uring fixed buffer before triggering the
bug. The DIO pin and the fixed-buffer pin account for two
GUP_PIN_COUNTING_BIAS references. GDB showed a refcount of 2050 at the
first erroneous unpin, followed by 2050 -> 1026 in the trim path and
1026 -> 2 in read-bounce completion. After munmap() and memfd
teardown, the page is freed while io_uring still retains its bvec and
old PFN.

I then reclaimed that PFN as the page-cache page containing the entry
point of a root-owned setuid ELF. IORING_OP_WRITE_FIXED was used as a
read oracle to confirm the reuse, and IORING_OP_READ_FIXED replaced
the entry point with a position-independent
setuid(0)/execve("/bin/sh") payload. This does not require a kernel
address leak or kernel control-flow hijacking.

The vulnerable kernel produced:

    $ id
    uid=1000(ctf) gid=1000(ctf) groups=1000(ctf)
    $ /bio_bounce_lpe
    [*] uid=1000
    [+] stale page hit
    [+] exec
    # id
    uid=0(root) gid=0(root) groups=1000(ctf)

With the proposed fix, using the same config, initramfs, NVMe PI
namespace and XFS setup, the exploit no longer obtains a stale page:

    $ /bio_bounce_lpe
    [*] uid=1000
    [-] stale page miss
    $ id
    uid=1000(ctf) gid=1000(ctf) groups=1000(ctf)

I repeated the fixed-kernel test on fresh images and obtained the same
result. The setuid target in the disposable VM was an unmodified
static BusyBox binary copied onto XFS and installed as root-owned mode
4755. It was only a convenient page-cache target: the exploit parses
the ELF entry point at runtime, does not depend on BusyBox behavior or
a hard-coded offset, and I also validated the same ending with a
dynamically linked PIE executable.

The attached patch changes bio_iov_iter_align_down() to accept the
index of the first vector it is allowed to trim. Existing callers pass
zero and read-bounce passes one. It also updates the bounce bvec
length after alignment and drops the bounce folio if alignment removes
all user data. I tested the resulting kernel in the same VM described
above.

I can provide the minimal trigger, full exploit, disposable initramfs,
exact QEMU command line, and the GDB transcript showing both unpins if
they would be useful for review.

Could you take a look at the analysis and patch? In particular, I
would appreciate your view on whether passing the first vector index
into the alignment helper is the right fix, or whether you would
prefer the read-bounce layout itself to be changed.

Regards,

0wnerD1ed
l7z@0b1t.tech

--0000000000002db5c5065640dad7
Content-Type: application/octet-stream; 
	name="0001-block-fix-bvec-offset-when-aligning-bounced-reads.patch"
Content-Disposition: attachment; 
	filename="0001-block-fix-bvec-offset-when-aligning-bounced-reads.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mrewte3w0>
X-Attachment-Id: f_mrewte3w0

RnJvbSBkYWU5MDI1YjM0MDNiY2VjYjJmMTIyNDMwNmNiNGI4YjIyYTZjMjdjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAwd25lckQxZWQgPGw3ekAwYjF0LnRlY2g+CkRhdGU6IEZyaSwg
MTAgSnVsIDIwMjYgMTk6MDU6NTggKzA4MDAKU3ViamVjdDogW1BBVENIXSBibG9jazogZml4IGJ2
ZWMgb2Zmc2V0IHdoZW4gYWxpZ25pbmcgYm91bmNlZCByZWFkcwoKYmlvX2lvdl9pdGVyX2JvdW5j
ZV9yZWFkKCkgc3RvcmVzIHRoZSBib3VuY2UgZm9saW8gaW4gYmlfaW9fdmVjWzBdIGFuZApleHRy
YWN0cyB1c2VyIGJ2ZWNzIHN0YXJ0aW5nIGF0IGJpX2lvX3ZlY1sxXS4gIGJpX3ZjbnQsIGhvd2V2
ZXIsIGNvdW50cwpvbmx5IHRoZSBleHRyYWN0ZWQgdXNlciBidmVjcy4KCmJpb19pb3ZfaXRlcl9h
bGlnbl9kb3duKCkgYXNzdW1lcyB0aGF0IHRoZSB2ZWN0b3JzIGl0IHRyaW1zIHN0YXJ0IGF0Cmlu
ZGV4IHplcm8uICBUaHVzLCB3aXRoIHR3byBleHRyYWN0ZWQgdXNlciBidmVjcyBpdCBzZWxlY3Rz
IGluZGV4IG9uZSBhcwp0aGUgbGFzdCB2ZWN0b3IgaW5zdGVhZCBvZiBpbmRleCB0d28uICBJZiB0
aGUgYWxpZ25tZW50IHJlbWFpbmRlcgpjb25zdW1lcyB0aGF0IHZlY3RvciwgYSBwaW5uZWQgdXNl
ciBwYWdlIGlzIHJlbGVhc2VkIGV2ZW4gdGhvdWdoIGl0IGlzCnN0aWxsIHByZXNlbnQgaW4gdGhl
IGNvbXBsZXRpb24tc2lkZSB2ZWN0b3IgYXJyYXkuICBDb21wbGV0aW9uIHJlbGVhc2VzCnRoZSBz
YW1lIHBhZ2UgYWdhaW4uCgpQYXNzIHRoZSBmaXJzdCB2ZWN0b3IgaW5kZXggdG8gdGhlIGFsaWdu
bWVudCBoZWxwZXIgYW5kIHVzZSBhbiBvZmZzZXQgb2YKb25lIGZvciBib3VuY2VkIHJlYWRzLiAg
QWZ0ZXIgdHJpbW1pbmcsIGFsc28gc3luY2hyb25pemUgdGhlIGJvdW5jZQpmb2xpbyBsZW5ndGgg
d2l0aCB0aGUgYWxpZ25lZCBiaW8gc2l6ZS4gIFJlbGVhc2UgdGhlIGJvdW5jZSBmb2xpbyBpZgph
bGlnbm1lbnQgcmVtb3ZlcyBhbGwgdXNlciBkYXRhLgoKRml4ZXM6IGU3YjhiM2M1YjJhNiAoImJs
b2NrOiBhbGlnbiBkb3duIGJvdW5jZXMgYmlvcyIpCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
ClNpZ25lZC1vZmYtYnk6IDB3bmVyRDFlZCA8bDd6QDBiMXQudGVjaD4KLS0tCiBibG9jay9iaW8u
YyB8IDE4ICsrKysrKysrKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMo
KyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYmxvY2svYmlvLmMgYi9ibG9jay9iaW8u
YwppbmRleCBmMmE1ZjRkMGE5NjcuLjZiN2Q4OTNkZjE2OSAxMDA2NDQKLS0tIGEvYmxvY2svYmlv
LmMKKysrIGIvYmxvY2svYmlvLmMKQEAgLTExOTEsNyArMTE5MSw3IEBAIHZvaWQgYmlvX2lvdl9i
dmVjX3NldChzdHJ1Y3QgYmlvICpiaW8sIGNvbnN0IHN0cnVjdCBpb3ZfaXRlciAqaXRlcikKICAq
IGZvciB0aGUgbmV4dCBpdGVyYXRpb24uCiAgKi8KIHN0YXRpYyBpbnQgYmlvX2lvdl9pdGVyX2Fs
aWduX2Rvd24oc3RydWN0IGJpbyAqYmlvLCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIsCi0JCQkgICAg
dW5zaWduZWQgbGVuX2FsaWduX21hc2spCisJCQkgICAgdW5zaWduZWQgaW50IGxlbl9hbGlnbl9t
YXNrLCB1bnNpZ25lZCBpbnQgZmlyc3RfdmVjKQogewogCXNpemVfdCBuYnl0ZXMgPSBiaW8tPmJp
X2l0ZXIuYmlfc2l6ZSAmIGxlbl9hbGlnbl9tYXNrOwogCkBAIC0xMjAxLDcgKzEyMDEsOCBAQCBz
dGF0aWMgaW50IGJpb19pb3ZfaXRlcl9hbGlnbl9kb3duKHN0cnVjdCBiaW8gKmJpbywgc3RydWN0
IGlvdl9pdGVyICppdGVyLAogCWlvdl9pdGVyX3JldmVydChpdGVyLCBuYnl0ZXMpOwogCWJpby0+
YmlfaXRlci5iaV9zaXplIC09IG5ieXRlczsKIAlkbyB7Ci0JCXN0cnVjdCBiaW9fdmVjICpidiA9
ICZiaW8tPmJpX2lvX3ZlY1tiaW8tPmJpX3ZjbnQgLSAxXTsKKwkJc3RydWN0IGJpb192ZWMgKmJ2
ID0KKwkJCSZiaW8tPmJpX2lvX3ZlY1tmaXJzdF92ZWMgKyBiaW8tPmJpX3ZjbnQgLSAxXTsKIAog
CQlpZiAobmJ5dGVzIDwgYnYtPmJ2X2xlbikgewogCQkJYnYtPmJ2X2xlbiAtPSBuYnl0ZXM7CkBA
IC0xMjc2LDcgKzEyNzcsNyBAQCBpbnQgYmlvX2lvdl9pdGVyX2dldF9wYWdlcyhzdHJ1Y3QgYmlv
ICpiaW8sIHN0cnVjdCBpb3ZfaXRlciAqaXRlciwKIAogCWlmIChpc19wY2lfcDJwZG1hX3BhZ2Uo
YmlvLT5iaV9pb192ZWMtPmJ2X3BhZ2UpKQogCQliaW8tPmJpX29wZiB8PSBSRVFfTk9NRVJHRTsK
LQlyZXR1cm4gYmlvX2lvdl9pdGVyX2FsaWduX2Rvd24oYmlvLCBpdGVyLCBsZW5fYWxpZ25fbWFz
ayk7CisJcmV0dXJuIGJpb19pb3ZfaXRlcl9hbGlnbl9kb3duKGJpbywgaXRlciwgbGVuX2FsaWdu
X21hc2ssIDApOwogfQogCiBzdGF0aWMgc3RydWN0IGZvbGlvICpmb2xpb19hbGxvY19ncmVlZHko
Z2ZwX3QgZ2ZwLCBzaXplX3QgKnNpemUsCkBAIC0xMzYwLDcgKzEzNjEsNyBAQCBzdGF0aWMgaW50
IGJpb19pb3ZfaXRlcl9ib3VuY2Vfd3JpdGUoc3RydWN0IGJpbyAqYmlvLCBzdHJ1Y3QgaW92X2l0
ZXIgKml0ZXIsCiAKIAlpZiAoIWJpby0+YmlfaXRlci5iaV9zaXplKQogCQlyZXR1cm4gLUVOT01F
TTsKLQlyZXR1cm4gYmlvX2lvdl9pdGVyX2FsaWduX2Rvd24oYmlvLCBpdGVyLCBtaW5zaXplIC0g
MSk7CisJcmV0dXJuIGJpb19pb3ZfaXRlcl9hbGlnbl9kb3duKGJpbywgaXRlciwgbWluc2l6ZSAt
IDEsIDApOwogfQogCiBzdGF0aWMgaW50IGJpb19pb3ZfaXRlcl9ib3VuY2VfcmVhZChzdHJ1Y3Qg
YmlvICpiaW8sIHN0cnVjdCBpb3ZfaXRlciAqaXRlciwKQEAgLTEzNjgsNiArMTM2OSw3IEBAIHN0
YXRpYyBpbnQgYmlvX2lvdl9pdGVyX2JvdW5jZV9yZWFkKHN0cnVjdCBiaW8gKmJpbywgc3RydWN0
IGlvdl9pdGVyICppdGVyLAogewogCXNpemVfdCBsZW4gPSBtaW4zKGlvdl9pdGVyX2NvdW50KGl0
ZXIpLCBtYXhsZW4sIFNaXzFNKTsKIAlzdHJ1Y3QgZm9saW8gKmZvbGlvOworCWludCByZXQ7CiAK
IAlmb2xpbyA9IGZvbGlvX2FsbG9jX2dyZWVkeShHRlBfS0VSTkVMLCAmbGVuLCBtaW5zaXplKTsK
IAlpZiAoIWZvbGlvKQpAQCAtMTM5OCw3ICsxNDAwLDEzIEBAIHN0YXRpYyBpbnQgYmlvX2lvdl9p
dGVyX2JvdW5jZV9yZWFkKHN0cnVjdCBiaW8gKmJpbywgc3RydWN0IGlvdl9pdGVyICppdGVyLAog
CWJ2ZWNfc2V0X2ZvbGlvKCZiaW8tPmJpX2lvX3ZlY1swXSwgZm9saW8sIGJpby0+YmlfaXRlci5i
aV9zaXplLCAwKTsKIAlpZiAoaW92X2l0ZXJfZXh0cmFjdF93aWxsX3BpbihpdGVyKSkKIAkJYmlv
X3NldF9mbGFnKGJpbywgQklPX1BBR0VfUElOTkVEKTsKLQlyZXR1cm4gYmlvX2lvdl9pdGVyX2Fs
aWduX2Rvd24oYmlvLCBpdGVyLCBtaW5zaXplIC0gMSk7CisJcmV0ID0gYmlvX2lvdl9pdGVyX2Fs
aWduX2Rvd24oYmlvLCBpdGVyLCBtaW5zaXplIC0gMSwgMSk7CisJaWYgKHJldCkgeworCQlmb2xp
b19wdXQoZm9saW8pOworCQlyZXR1cm4gcmV0OworCX0KKwliaW8tPmJpX2lvX3ZlY1swXS5idl9s
ZW4gPSBiaW8tPmJpX2l0ZXIuYmlfc2l6ZTsKKwlyZXR1cm4gMDsKIH0KIAogLyoqCi0tIAoyLjM0
LjEKCg==
--0000000000002db5c5065640dad7--
