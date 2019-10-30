Return-Path: <SRS0=yN0i=YX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3D6CA9EC7
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 22:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CAB2083E
	for <linux-block@archiver.kernel.org>; Wed, 30 Oct 2019 22:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfJ3WGn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Oct 2019 18:06:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39642 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfJ3WGn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 18:06:43 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id B13CC28EDAC
Subject: Re: [PATCH blktests 1/3] check: Add configuration file option
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com, kernel@collabora.com,
        krisman@collabora.com
References: <20191029200942.83044-1-andrealmeid@collabora.com>
 <20191029200942.83044-2-andrealmeid@collabora.com>
 <20191030211652.GB326591@vader>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <2f9f649b-31db-b774-5c41-1d5f4340881e@collabora.com>
Date:   Wed, 30 Oct 2019 19:05:14 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191030211652.GB326591@vader>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/30/19 6:16 PM, Omar Sandoval wrote:
> On Tue, Oct 29, 2019 at 05:09:40PM -0300, André Almeida wrote:
>> Add an option to be possible to use a different configuration file
>> rather than the default "config" file.
>>
>> Signed-off-by: André Almeida <andrealmeid@collabora.com>
>> ---
>>  check | 29 ++++++++++++++++++++++++-----
>>  1 file changed, 24 insertions(+), 5 deletions(-)
>>
>> diff --git a/check b/check
>> index 981058c..936b0c3 100755
>> --- a/check
>> +++ b/check
>> @@ -635,6 +635,9 @@ Test runs:
>>    -x, --exclude=TEST	 exclude a test (or test group) from the list of
>>  			 tests to run
>>  
>> +  -c, --config=FILE	 use FILE for loading configuration instead of
>> +			 default 'config' filename.
>> +
>>  Miscellaneous:
>>    -h, --help             display this help message and exit"
>>  
>> @@ -650,7 +653,7 @@ Miscellaneous:
>>  	esac
>>  }
>>  
>> -if ! TEMP=$(getopt -o 'do:q::x:h' --long 'quick::,exclude:,output:,help' -n "$0" -- "$@"); then
>> +if ! TEMP=$(getopt -o 'do:q::x:c:h' --long 'quick::,exclude:,output:,config:,help' -n "$0" -- "$@"); then
>>  	exit 1
>>  fi
>>  
>> @@ -659,10 +662,8 @@ unset TEMP
>>  
>>  LOGGER_PROG="$(type -P logger)" || LOGGER_PROG=true
>>  
>> -if [[ -r config ]]; then
>> -	# shellcheck disable=SC1091
>> -	. config
>> -fi
>> +# true if the default configuration file "config" should be used
>> +DEFAULT_CONFIG=true
>>  
>>  # Default configuration.
>>  : "${DEVICE_ONLY:=0}"
>> @@ -706,6 +707,17 @@ while true; do
>>  			EXCLUDE+=("$2")
>>  			shift 2
>>  			;;
>> +		'-c'|'--config')
>> +			if [[ -r "$2" ]]; then
>> +				# shellcheck source=/dev/null
>> +				. "$2"
>> +				DEFAULT_CONFIG=false
>> +			else
>> +				echo "Configuration file $2 not found!"
>> +				usage err
>> +			fi
>> +			shift 2
>> +			;;
> 
> If the user specifies -c multiple times, it will source each one, not
> just the last one. Is that intentional? That might actually be a useful
> feature, but we'd want to document it.

Hmm, good question. Actually, I wasn't thinking about that when I
created this feature. I believe that using all the multiple `-c <file>`
is more useful than just using the last one. I will send a v2
documenting this behavior.

> 
>>  		'-h'|'--help')
>>  			usage out
>>  			;;
>> @@ -719,6 +731,13 @@ while true; do
>>  	esac
>>  done
>>  
>> +# if '-c' was not used, try to use the default config file
>> +if [[ -r config ]] && $DEFAULT_CONFIG; then
>> +	# shellcheck source=/dev/null
>> +	. config
>> +fi
>> +
>> +
>>  if [[ $QUICK_RUN -ne 0 && ! "${TIMEOUT:-}" ]]; then
>>  	_error "QUICK_RUN specified without TIMEOUT"
>>  fi
>> -- 
>> 2.23.0
>>

