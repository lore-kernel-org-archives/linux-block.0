Return-Path: <SRS0=FPpm=YW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED70CA9EAE
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 20:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639B72083E
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 20:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfJ2ULf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:11:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54684 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJ2ULf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 16:11:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 487E628F122
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@fb.com, kernel@collabora.com, krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH blktests 1/3] check: Add configuration file option
Date:   Tue, 29 Oct 2019 17:09:40 -0300
Message-Id: <20191029200942.83044-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191029200942.83044-1-andrealmeid@collabora.com>
References: <20191029200942.83044-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add an option to be possible to use a different configuration file
rather than the default "config" file.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 check | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/check b/check
index 981058c..936b0c3 100755
--- a/check
+++ b/check
@@ -635,6 +635,9 @@ Test runs:
   -x, --exclude=TEST	 exclude a test (or test group) from the list of
 			 tests to run
 
+  -c, --config=FILE	 use FILE for loading configuration instead of
+			 default 'config' filename.
+
 Miscellaneous:
   -h, --help             display this help message and exit"
 
@@ -650,7 +653,7 @@ Miscellaneous:
 	esac
 }
 
-if ! TEMP=$(getopt -o 'do:q::x:h' --long 'quick::,exclude:,output:,help' -n "$0" -- "$@"); then
+if ! TEMP=$(getopt -o 'do:q::x:c:h' --long 'quick::,exclude:,output:,config:,help' -n "$0" -- "$@"); then
 	exit 1
 fi
 
@@ -659,10 +662,8 @@ unset TEMP
 
 LOGGER_PROG="$(type -P logger)" || LOGGER_PROG=true
 
-if [[ -r config ]]; then
-	# shellcheck disable=SC1091
-	. config
-fi
+# true if the default configuration file "config" should be used
+DEFAULT_CONFIG=true
 
 # Default configuration.
 : "${DEVICE_ONLY:=0}"
@@ -706,6 +707,17 @@ while true; do
 			EXCLUDE+=("$2")
 			shift 2
 			;;
+		'-c'|'--config')
+			if [[ -r "$2" ]]; then
+				# shellcheck source=/dev/null
+				. "$2"
+				DEFAULT_CONFIG=false
+			else
+				echo "Configuration file $2 not found!"
+				usage err
+			fi
+			shift 2
+			;;
 		'-h'|'--help')
 			usage out
 			;;
@@ -719,6 +731,13 @@ while true; do
 	esac
 done
 
+# if '-c' was not used, try to use the default config file
+if [[ -r config ]] && $DEFAULT_CONFIG; then
+	# shellcheck source=/dev/null
+	. config
+fi
+
+
 if [[ $QUICK_RUN -ne 0 && ! "${TIMEOUT:-}" ]]; then
 	_error "QUICK_RUN specified without TIMEOUT"
 fi
-- 
2.23.0

