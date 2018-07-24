Return-Path: <keescook@chromium.org>
Return-Path: <keescook@chromium.org>
From: Kees Cook <keescook@chromium.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Kees Cook <keescook@chromium.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Eric Biggers <ebiggers@google.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alasdair Kergon <agk@redhat.com>,
	Rabin Vincent <rabinv@axis.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Pavel Machek <pavel@ucw.cz>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Mike Snitzer <snitzer@redhat.com>,
	Paul Mackerras <paulus@samba.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Howells <dhowells@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
	Jia-Ju Bai <baijiaju1990@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Will Deacon <will.deacon@arm.com>,
	dm-devel@redhat.com,
	linux-pm@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	qat-linux@intel.com,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-afs@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/18] crypto: cbc: Remove VLA usage
Date: Tue, 24 Jul 2018 09:49:20 -0700
Message-Id: <20180724164936.37477-3-keescook@chromium.org>
In-Reply-To: <20180724164936.37477-1-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org>
List-ID: <linux-block@vger.kernel.org>

In the quest to remove all stack VLA usage from the kernel[1], this
uses the upper bounds on blocksize. Since this is always a cipher
blocksize, use the existing cipher max blocksize.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/crypto/cbc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/crypto/cbc.h b/include/crypto/cbc.h
index f5b8bfc22e6d..47db0aac2ab9 100644
--- a/include/crypto/cbc.h
+++ b/include/crypto/cbc.h
@@ -113,7 +113,9 @@ static inline int crypto_cbc_decrypt_inplace(
 	unsigned int bsize = crypto_skcipher_blocksize(tfm);
 	unsigned int nbytes = walk->nbytes;
 	u8 *src = walk->src.virt.addr;
-	u8 last_iv[bsize];
+	u8 last_iv[MAX_CIPHER_BLOCKSIZE];
+
+	BUG_ON(bsize > sizeof(last_iv));
 
 	/* Start of the last block. */
 	src += nbytes - (nbytes & (bsize - 1)) - bsize;
-- 
2.17.1
