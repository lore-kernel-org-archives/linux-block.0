Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <82ee3a59-1767-3073-7893-bf78b5933c5e@kernel.dk>
References: <82ee3a59-1767-3073-7893-bf78b5933c5e@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 17 Nov 2017 11:29:40 -0800
Message-ID: <CA+55aFy34p7YAtts5e0Uxt5drKws8QHw5nPDoBi64YX2xXnLrw@mail.gmail.com>
Subject: Re: [GIT PULL] Followup merge window block fixes/changes
To: Jens Axboe <axboe@kernel.dk>, Luca Miccio <lucmiccio@gmail.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: multipart/mixed; boundary="001a113a355a1312aa055e32c20f"
List-ID: <linux-block@vger.kernel.org>

--001a113a355a1312aa055e32c20f
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 17, 2017 at 8:51 AM, Jens Axboe <axboe@kernel.dk> wrote:
>
> - Small BFQ updates series from Luca and Paolo.

Honestly, this code is too ugly to live.

Seriously. That update should have been rejected on the grounds of
being completely unmaintainable crap.

Why didn't you?

Why are you allowing code like that patch to bfq_dispatch_request()
into the kernel source tree?

Yes, it improves performance. But it does so by adding random
#iofdef's into the middle of some pretty crtitical code, with
absolutely no attempt at having a sane maintainable code-base.

That function is literally *three* lines of code without the #ifdef case:

        spin_lock_irq(&bfqd->lock);
        rq = __bfq_dispatch_request(hctx);
        spin_unlock_irq(&bfqd->lock);

and you could actually see what it did.

But instead of trying to abstract it in some legible manner, that
three-line obvious function got *three* copies of the same #if mess
all enclosing rancom crap, and the end result is really hard to read.

For example, I just spent a couple of minutes trying to make sense of
the code, and stop that unreadable mess.  I came up with the appended
patch.

It may not work for some reason I can't see, but that's not the point.
The attached patch is not meant as a "apply this as-is".

It's meant as a "look, you can write legible code where the statistics
just go away when they are compiled out".

Now that "obvious three-liner function" is not three lines any more,
but it's at least *clear* straight-line code:

        spin_lock_irq(&bfqd->lock);

        in_serv_queue = bfqd->in_service_queue;
        waiting_rq = in_serv_queue && bfq_bfqq_wait_request(in_serv_queue);

        rq = __bfq_dispatch_request(hctx);

        idle_timer_disabled =
                waiting_rq && !bfq_bfqq_wait_request(in_serv_queue);

        spin_unlock_irq(&bfqd->lock);

        bfq_dispatch_statistics(hctx, rq, in_serv_queue, waiting_rq,
idle_timer_disabled);

and I am  hopeful that when bfq_dispatch_statistics() is disabled, the
compiler will be smart enough to not generate extra code, certainly
not noticeably so.

See? One is a mess of horrible ugly #ifdef's in the middle of the code
that makes the end result completely illegible.

The other is actually somewhat legible, and has a clear separation of
the statistics gathering. And that *statistics* gathering is clearly
optionally enabled or not.

Not the mess of random code put together in random ways that are
completely illegble.

Your job as maintainer is _literally_ to tell people "f*ck no, that
code is too ugly, you need to write it so that it can be maintained".

And I'm doing my job.

"F*ck no, that code is too ugly, you need to write it so that it can
be maintained".

Show some taste.

                Linus

--001a113a355a1312aa055e32c20f
Content-Type: text/plain; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ja4aqxnu0

IGJsb2NrL2JmcS1pb3NjaGVkLmMgfCA1NSArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyks
IDI2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Jsb2NrL2JmcS1pb3NjaGVkLmMgYi9ibG9j
ay9iZnEtaW9zY2hlZC5jCmluZGV4IGJjYjZkMjFiYWYxMi4uNDdkODhkMDNkYWRkIDEwMDY0NAot
LS0gYS9ibG9jay9iZnEtaW9zY2hlZC5jCisrKyBiL2Jsb2NrL2JmcS1pb3NjaGVkLmMKQEAgLTM2
ODksMzUgKzM2ODksMTQgQEAgc3RhdGljIHN0cnVjdCByZXF1ZXN0ICpfX2JmcV9kaXNwYXRjaF9y
ZXF1ZXN0KHN0cnVjdCBibGtfbXFfaHdfY3R4ICpoY3R4KQogCXJldHVybiBycTsKIH0KIAotc3Rh
dGljIHN0cnVjdCByZXF1ZXN0ICpiZnFfZGlzcGF0Y2hfcmVxdWVzdChzdHJ1Y3QgYmxrX21xX2h3
X2N0eCAqaGN0eCkKLXsKLQlzdHJ1Y3QgYmZxX2RhdGEgKmJmcWQgPSBoY3R4LT5xdWV1ZS0+ZWxl
dmF0b3ItPmVsZXZhdG9yX2RhdGE7Ci0Jc3RydWN0IHJlcXVlc3QgKnJxOwotI2lmIGRlZmluZWQo
Q09ORklHX0JGUV9HUk9VUF9JT1NDSEVEKSAmJiBkZWZpbmVkKENPTkZJR19ERUJVR19CTEtfQ0dS
T1VQKQotCXN0cnVjdCBiZnFfcXVldWUgKmluX3NlcnZfcXVldWUsICpiZnFxOwotCWJvb2wgd2Fp
dGluZ19ycSwgaWRsZV90aW1lcl9kaXNhYmxlZDsKLSNlbmRpZgotCi0Jc3Bpbl9sb2NrX2lycSgm
YmZxZC0+bG9jayk7Ci0KICNpZiBkZWZpbmVkKENPTkZJR19CRlFfR1JPVVBfSU9TQ0hFRCkgJiYg
ZGVmaW5lZChDT05GSUdfREVCVUdfQkxLX0NHUk9VUCkKLQlpbl9zZXJ2X3F1ZXVlID0gYmZxZC0+
aW5fc2VydmljZV9xdWV1ZTsKLQl3YWl0aW5nX3JxID0gaW5fc2Vydl9xdWV1ZSAmJiBiZnFfYmZx
cV93YWl0X3JlcXVlc3QoaW5fc2Vydl9xdWV1ZSk7Ci0KLQlycSA9IF9fYmZxX2Rpc3BhdGNoX3Jl
cXVlc3QoaGN0eCk7Ci0KLQlpZGxlX3RpbWVyX2Rpc2FibGVkID0KLQkJd2FpdGluZ19ycSAmJiAh
YmZxX2JmcXFfd2FpdF9yZXF1ZXN0KGluX3NlcnZfcXVldWUpOwotCi0jZWxzZQotCXJxID0gX19i
ZnFfZGlzcGF0Y2hfcmVxdWVzdChoY3R4KTsKLSNlbmRpZgotCXNwaW5fdW5sb2NrX2lycSgmYmZx
ZC0+bG9jayk7CitzdGF0aWMgdm9pZCBiZnFfZGlzcGF0Y2hfc3RhdGlzdGljcyhzdHJ1Y3QgYmxr
X21xX2h3X2N0eCAqaGN0eCwgc3RydWN0IHJlcXVlc3QgKnJxLAorCXN0cnVjdCBiZnFfcXVldWUg
KmluX3NlcnZfcXVldWUsIGJvb2wgd2FpdGluZ19ycSwgYm9vbCBpZGxlX3RpbWVyX2Rpc2FibGVk
KQoreworCXN0cnVjdCBiZnFfcXVldWUgKmJmcXEgPSBycSA/IFJRX0JGUVEocnEpIDogTlVMTDsK
IAotI2lmIGRlZmluZWQoQ09ORklHX0JGUV9HUk9VUF9JT1NDSEVEKSAmJiBkZWZpbmVkKENPTkZJ
R19ERUJVR19CTEtfQ0dST1VQKQotCWJmcXEgPSBycSA/IFJRX0JGUVEocnEpIDogTlVMTDsKIAlp
ZiAoIWlkbGVfdGltZXJfZGlzYWJsZWQgJiYgIWJmcXEpCi0JCXJldHVybiBycTsKKwkJcmV0dXJu
OwogCiAJLyoKIAkgKiBycSBhbmQgYmZxcSBhcmUgZ3VhcmFudGVlZCB0byBleGlzdCB1bnRpbCB0
aGlzIGZ1bmN0aW9uCkBAIC0zNzUyLDggKzM3MzEsMzIgQEAgc3RhdGljIHN0cnVjdCByZXF1ZXN0
ICpiZnFfZGlzcGF0Y2hfcmVxdWVzdChzdHJ1Y3QgYmxrX21xX2h3X2N0eCAqaGN0eCkKIAkJYmZx
Z19zdGF0c191cGRhdGVfaW9fcmVtb3ZlKGJmcWcsIHJxLT5jbWRfZmxhZ3MpOwogCX0KIAlzcGlu
X3VubG9ja19pcnEoaGN0eC0+cXVldWUtPnF1ZXVlX2xvY2spOworfQorI2Vsc2UKK3N0YXRpYyBp
bmxpbmUgdm9pZCBiZnFfZGlzcGF0Y2hfc3RhdGlzdGljcyhzdHJ1Y3QgYmxrX21xX2h3X2N0eCAq
aGN0eCwgc3RydWN0IHJlcXVlc3QgKnJxLCBzdHJ1Y3QgYmZxX3F1ZXVlICppbl9zZXJ2X3F1ZXVl
LCBib29sIHdhaXRpbmdfcnEsIGJvb2wgaWRsZV90aW1lcl9kaXNhYmxlZCkge30KICNlbmRpZgog
CitzdGF0aWMgc3RydWN0IHJlcXVlc3QgKmJmcV9kaXNwYXRjaF9yZXF1ZXN0KHN0cnVjdCBibGtf
bXFfaHdfY3R4ICpoY3R4KQoreworCXN0cnVjdCBiZnFfZGF0YSAqYmZxZCA9IGhjdHgtPnF1ZXVl
LT5lbGV2YXRvci0+ZWxldmF0b3JfZGF0YTsKKwlzdHJ1Y3QgcmVxdWVzdCAqcnE7CisJc3RydWN0
IGJmcV9xdWV1ZSAqaW5fc2Vydl9xdWV1ZTsKKwlib29sIHdhaXRpbmdfcnEsIGlkbGVfdGltZXJf
ZGlzYWJsZWQ7CisKKwlzcGluX2xvY2tfaXJxKCZiZnFkLT5sb2NrKTsKKworCWluX3NlcnZfcXVl
dWUgPSBiZnFkLT5pbl9zZXJ2aWNlX3F1ZXVlOworCXdhaXRpbmdfcnEgPSBpbl9zZXJ2X3F1ZXVl
ICYmIGJmcV9iZnFxX3dhaXRfcmVxdWVzdChpbl9zZXJ2X3F1ZXVlKTsKKworCXJxID0gX19iZnFf
ZGlzcGF0Y2hfcmVxdWVzdChoY3R4KTsKKworCWlkbGVfdGltZXJfZGlzYWJsZWQgPQorCQl3YWl0
aW5nX3JxICYmICFiZnFfYmZxcV93YWl0X3JlcXVlc3QoaW5fc2Vydl9xdWV1ZSk7CisKKwlzcGlu
X3VubG9ja19pcnEoJmJmcWQtPmxvY2spOworCisJYmZxX2Rpc3BhdGNoX3N0YXRpc3RpY3MoaGN0
eCwgcnEsIGluX3NlcnZfcXVldWUsIHdhaXRpbmdfcnEsIGlkbGVfdGltZXJfZGlzYWJsZWQpOwor
CiAJcmV0dXJuIHJxOwogfQogCg==
--001a113a355a1312aa055e32c20f--
