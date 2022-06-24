Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786BBC43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 23:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiFXXr2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 19:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiFXXr1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 19:47:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03A38BEC4;
        Fri, 24 Jun 2022 16:47:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 70CD71F891;
        Fri, 24 Jun 2022 23:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656114445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aobWKircXEKbGTkT46vsoN1mG2oAxEWPsS6CajoA/6U=;
        b=uoAaIrouqAUg4vn7RsvgiNCjACanuj9PzdM5fzvNQcyYQ5WhnxPSzG9ByaKlAXiBqmQkwx
        8qn89Q9/xpl/cQmHs0Rw9pHZ1yP8J0RXVfZlqJlenR1qjqOD4WTtP6HcEsqzhBGVp+UBvJ
        mDJwXEj0PoIDF9jnXRVQ6XzorSdnXhc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38B7113ACA;
        Fri, 24 Jun 2022 23:47:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n38fDA1NtmLyUgAAMHmgww
        (envelope-from <mwilck@suse.com>); Fri, 24 Jun 2022 23:47:25 +0000
Message-ID: <c2dfae29bb2aa3b6286a3a225a27b116761b9e53.camel@suse.com>
Subject: Re: [PATCH] lib/sbitmap: Fix invalid loop in
 __sbitmap_queue_get_batch()
From:   Martin Wilck <mwilck@suse.com>
To:     wuchi <wuchi.zero@gmail.com>, axboe@kernel.dk,
        andriy.shevchenko@linux.intel.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 25 Jun 2022 01:47:24 +0200
In-Reply-To: <20220605145835.26916-1-wuchi.zero@gmail.com>
References: <20220605145835.26916-1-wuchi.zero@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gU3VuLCAyMDIyLTA2LTA1IGF0IDIyOjU4ICswODAwLCB3dWNoaSB3cm90ZToKPiAxLiBHZXR0
aW5nIG5leHQgaW5kZXggYmVmb3JlIGNvbnRpbnVlIGJyYW5jaC4KPiAyLiBDaGVja2luZyBmcmVl
IGJpdHMgd2hlbiBzZXR0aW5nIHRoZSB0YXJnZXQgYml0cy4gT3RoZXJ3aXNlLAo+IGl0IG1heSBy
ZXVzZSB0aGUgYnVzeWluZyBiaXRzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IHd1Y2hpIDx3dWNoaS56
ZXJvQGdtYWlsLmNvbT4KClJldmlld2VkLWJ5OiBNYXJ0aW4gV2lsY2sgPG13aWxja0BzdXNlLmNv
bT4KCj4gLS0tCj4goGxpYi9zYml0bWFwLmMgfCA1ICsrKystCj4goDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvbGliL3NiaXRt
YXAuYyBiL2xpYi9zYml0bWFwLmMKPiBpbmRleCBhZTRmZDRkZTllYmUuLjI5ZWIwNDg0MjE1YSAx
MDA2NDQKPiAtLS0gYS9saWIvc2JpdG1hcC5jCj4gKysrIGIvbGliL3NiaXRtYXAuYwo+IEBAIC01
MjgsNyArNTI4LDcgQEAgdW5zaWduZWQgbG9uZyBfX3NiaXRtYXBfcXVldWVfZ2V0X2JhdGNoKHN0
cnVjdAo+IHNiaXRtYXBfcXVldWUgKnNicSwgaW50IG5yX3RhZ3MsCj4goAo+IKCgoKCgoKCgoKCg
oKCgoKBzYml0bWFwX2RlZmVycmVkX2NsZWFyKG1hcCk7Cj4goKCgoKCgoKCgoKCgoKCgoGlmICht
YXAtPndvcmQgPT0gKDFVTCA8PCAobWFwX2RlcHRoIC0gMSkpIC0gMSkKPiAtoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKBjb250aW51ZTsKPiAroKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBnb3RvIG5leHQ7
Cj4goAo+IKCgoKCgoKCgoKCgoKCgoKBuciA9IGZpbmRfZmlyc3RfemVyb19iaXQoJm1hcC0+d29y
ZCwgbWFwX2RlcHRoKTsKPiCgoKCgoKCgoKCgoKCgoKCgaWYgKG5yICsgbnJfdGFncyA8PSBtYXBf
ZGVwdGgpIHsKPiBAQCAtNTM5LDYgKzUzOSw4IEBAIHVuc2lnbmVkIGxvbmcgX19zYml0bWFwX3F1
ZXVlX2dldF9iYXRjaChzdHJ1Y3QKPiBzYml0bWFwX3F1ZXVlICpzYnEsIGludCBucl90YWdzLAo+
IKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGdldF9tYXNrID0gKCgxVUwgPDwgbWFwX3RhZ3MpIC0g
MSkgPDwgbnI7Cj4goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgZG8gewo+IKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgdmFsID0gUkVBRF9PTkNFKG1hcC0+d29yZCk7Cj4gK6CgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBpZiAoKHZhbCAmIH5nZXRfbWFzaykgIT0gdmFsKQo+ICug
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBnb3RvIG5leHQ7Cj4goKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKByZXQgPSBhdG9taWNfbG9uZ19jbXB4Y2hnKHB0ciwg
dmFsLAo+IGdldF9tYXNrIHwgdmFsKTsKPiCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKB9IHdoaWxl
IChyZXQgIT0gdmFsKTsKPiCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBnZXRfbWFzayA9IChnZXRf
bWFzayAmIH5yZXQpID4+IG5yOwo+IEBAIC01NDksNiArNTUxLDcgQEAgdW5zaWduZWQgbG9uZyBf
X3NiaXRtYXBfcXVldWVfZ2V0X2JhdGNoKHN0cnVjdAo+IHNiaXRtYXBfcXVldWUgKnNicSwgaW50
IG5yX3RhZ3MsCj4goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKByZXR1cm4gZ2V0X21h
c2s7Cj4goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgfQo+IKCgoKCgoKCgoKCgoKCgoKB9Cj4gK25l
eHQ6Cj4goKCgoKCgoKCgoKCgoKCgoC8qIEp1bXAgdG8gbmV4dCBpbmRleC4gKi8KPiCgoKCgoKCg
oKCgoKCgoKCgaWYgKCsraW5kZXggPj0gc2ItPm1hcF9ucikKPiCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKBpbmRleCA9IDA7Cgo=

