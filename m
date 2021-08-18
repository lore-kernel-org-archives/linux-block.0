Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA2DC4320A
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 21:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38C09610A5
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 21:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbhHRVXD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 17:23:03 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:39158 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230506AbhHRVXC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 17:23:02 -0400
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 878D31848505F;
        Wed, 18 Aug 2021 21:22:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 42B3320A297;
        Wed, 18 Aug 2021 21:22:25 +0000 (UTC)
Message-ID: <23c8ebaa0921d5597df9fc1d6cbbcc4f354f80c5.camel@perches.com>
Subject: Re: [RFC PATCH 1/5] checkpatch: improve handling of revert commits
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Jiri Kosina <jkosina@suse.cz>,
        Willy Tarreau <w@1wt.eu>
Date:   Wed, 18 Aug 2021 14:22:23 -0700
In-Reply-To: <3d347d4b-1576-754f-8633-ba6084cc0661@linux.com>
References: <20210818154646.925351-1-efremov@linux.com>
         <20210818154646.925351-2-efremov@linux.com>
         <cc5801790fea258e20fa6b7e26de7806ae8e0dda.camel@perches.com>
         <3d347d4b-1576-754f-8633-ba6084cc0661@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Stat-Signature: pia39gbk7oo3ws6cnkt79e1s3fk5kp9d
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 42B3320A297
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+xCm96ndFXzv/PD4vqbk7Q+/a51qSjMXg=
X-HE-Tag: 1629321745-465152
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey Denis:

Try this one please and let me know what you think...

---
 scripts/checkpatch.pl | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 161ce7fe5d1e5..4e2e79eff9b8c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3196,26 +3196,21 @@ sub process {
 				$orig_commit = lc($1);
 			}
 
-			$short = 0 if ($line =~ /\bcommit\s+[0-9a-f]{12,40}/i);
-			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
-			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
-			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
-			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
-				$orig_desc = $1;
-				$hasparens = 1;
-			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
-				 defined $rawlines[$linenr] &&
-				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
-				$orig_desc = $1;
-				$hasparens = 1;
-			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
-				 defined $rawlines[$linenr] &&
-				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
-				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
+			my $input = $line;
+			for (my $n = 0; $n < 2; $n++) {
+				$input .= " $rawlines[$linenr + $n]" if ($#lines >= $linenr + $n);
+			}
+
+			$short = 0 if ($input =~ /\bcommit\s+[0-9a-f]{12,40}/i);
+			$long = 1 if ($input =~ /\bcommit\s+[0-9a-f]{41,}/i);
+			$space = 0 if ($input =~ /\bcommit [0-9a-f]/i);
+			$case = 0 if ($input =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
+			if ($input =~ /\bcommit\s+[0-9a-f]{5,}\s+($balanced_parens)/i) {
 				$orig_desc = $1;
-				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
-				$orig_desc .= " " . $1;
 				$hasparens = 1;
+				# Always strip leading/trailing parens then double quotes if existing
+				$orig_desc = substr($orig_desc, 1, -1);
+				$orig_desc = substr($orig_desc, 1, -1) if ($orig_desc =~ /^".*"$/);
 			}
 
 			($id, $description) = git_commit_info($orig_commit,


